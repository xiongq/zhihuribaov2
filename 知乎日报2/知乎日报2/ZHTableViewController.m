//
//  ZHTableViewController.m
//  知乎日报2
//
//  Created by xiong on 15/11/20.
//  Copyright © 2015年 xiong. All rights reserved.
// 启动图片

//http://news-at.zhihu.com/api/4/start-image/750*1334?client=0
#import "ZHTableViewController.h"
#import "UINavigationBar+Awesome.h"
#import "ZHstoryModel.h"
#import "ZHTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "afnGETPOST.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "ZHNewsController.h"



CGFloat topViewH = 350;
#define NAVBAR_CHANGE_POINT -175

@interface ZHTableViewController ()<loadMoreStoryIDDelegate>
@property (weak, nonatomic  ) UIImageView    *zoom;
@property (strong, nonatomic) NSMutableArray *story;
@property (strong, nonatomic) NSMutableArray *top_story;
@property (strong, nonatomic) NSMutableArray *timeArray;
@property (strong, nonatomic) NSString       *dates;

@end

@implementation ZHTableViewController
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    NSLog(@"will---");
//    //获取最新新闻
//    //    self.navigationController.navigationBarHidden= NO;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        [self loadNewNews];
//        [self loadTimeArray];
//        
//        //            dispatch_async(dispatch_get_main_queue(), ^{
//        //                [self.tableView reloadData];
//        //            });
//        
//    });
//}
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
////    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"load---");
//    获取最新新闻
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [self loadNewNews];
            [self loadTimeArray];
        
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.tableView reloadData];
//            });
        
    });
    self.title = @"知乎日报";
    /**
     *  设置导航栏颜色
     */
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    
    /**
     *  设置顶部滚动视图
     */
    self.tableView.contentInset = UIEdgeInsetsMake(topViewH * 0.5, 0, 0, 0);
    UIImageView *zoomView       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car"]
                             ];
    zoomView.frame              = CGRectMake(0, -topViewH, self.view.frame.size.width, topViewH);
    zoomView.contentMode        = UIViewContentModeScaleAspectFill;
    zoomView.clipsToBounds      = YES;
    [self.tableView insertSubview:zoomView atIndex:0];
    self.zoom                   = zoomView;
    
//    NSLog(@"%f",(self.view.frame.size.height - topViewH *0.5 - 64) / 5);
    [self.tableView addFooterWithTarget:self action:@selector(footresh)];
//    [self.tableView addHeaderWithTarget:self action:@selector(footresh)];
}

#pragma mark - 获取最新新闻

-(void)loadNewNews{
    //    https://news-at.zhihu.com/api/4/news/latest
    NSString *lastStory  = @"https://news-at.zhihu.com/api/4/news/latest";
    [afnGETPOST GETURL:lastStory prames:nil success:^(id json) {
//
        self.dates = json[@"date"];
        
        //今天的故事
        NSMutableArray *story = [Stories mj_objectArrayWithKeyValuesArray:json[@"stories"]];
        self.story = story;
        
        //top5故事
        NSMutableArray *top_story = [Top_Stories mj_objectArrayWithKeyValuesArray:json[@"top_stories"]];
        self.top_story = top_story;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
//获取最新新闻
-(void)loadOldNews{
    /**
     *  1.先获取新闻时间
     *  2.把这个时间放到数组中比较 获取索引。如果找到了，就索引+1（获取第二天的时间发送请求）
     *  3.如果找不到就去数组的第一个索引也就是0，发送请求
     *
     */
    NSString *time;
    /**
     *  如果这个字符不在数组也会返回一个超长的数字，不会返回nil
     */
    NSUInteger index = [self.timeArray indexOfObject:self.dates];
    if (index == 0) {
        /**
         *  如果index = 0 就是今天，也就是已经加载了，就跳过取下标是1的
         */
        time = [self.timeArray objectAtIndex:1];
    }else if(index <= self.timeArray.count -1){
        /**
         *  如果索引小余或等于数组个数减1，在数组里面（排除第一个，从1开始）
         *  ！！！至于为什么减1，---》数组索引是0开始，数组个数是1开始
         *  假如数组个数为3，下标 0，1，2  个数对应是1，2，3
         */
        time = [self.timeArray objectAtIndex:index];
    }else{
        /**
         *  如果越界就return结束，且结束刷新
         */
        [self.tableView footerEndRefreshing];
        /**
         *  DO IT
         */
        return;
    }
    

    //    http://news-at.zhihu.com/api/4/stories/before/

    NSString *url = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/stories/before/%@",time];
    [afnGETPOST GETURL:url prames:nil success:^(id json) {

        self.dates = json[@"date"];
        NSMutableArray *story = [Stories mj_objectArrayWithKeyValuesArray:json[@"stories"]];
        /**
         *  讲数组对象插到最前面
         */
//        NSRange range = NSMakeRange(0, story.count);
//        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
//        [self.story insertObjects:story atIndexes:set];
        
        
        /**
         *  讲数组对象插刀数组末
         */
        [self.story addObjectsFromArray:story];
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"complete" object:nil];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//获取时间数组
-(void)loadTimeArray{
    self.timeArray = [NSMutableArray new];
//    http://news-at.zhihu.com/api/4/stories/before/
    NSDate *time = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"YYYYMMdd"];
    for (NSInteger i  = 0; i < 14; i++) {
        NSDate *oldDay  = [NSDate dateWithTimeInterval:-60*60*24*i sinceDate:time];
        NSString *strTime = [formatter stringFromDate:oldDay];
        [self.timeArray addObject:strTime];
             }
//    NSLog(@"date---%lu",(unsigned long)self.timeArray.count);

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.story.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"apps" forIndexPath:indexPath];

    
    Stories *stoys = self.story[indexPath.row];

    cell.titile.text = stoys.title;
    cell.icon.clipsToBounds = YES;
    NSURL *url = [NSURL URLWithString:stoys.images.firstObject];
    [cell.icon sd_setImageWithURL:url] ;
    if (stoys.multipic == 0) {
        cell.mutile.hidden = YES;
    }
    return cell;
}
// 选中跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHNewsController *news = [self.storyboard instantiateViewControllerWithIdentifier:@"webview"];
    news.delegate = self;
    Stories *stoys = self.story[indexPath.row];
    news.id  = stoys.id;
    news.row = indexPath.row;
    news.storys = self.story;
    [self.navigationController pushViewController:news animated:YES];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (self.view.frame.size.height - topViewH *0.5 - 64) / 5;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //隐藏第一个头
    if (section == 0) {
        return nil;
    }
    return [NSString stringWithFormat:@"header for section %ld",(long)section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat heigh = 0;
    if (section == 0) {
        //设置0是默认
        heigh = 0.1;
    }else{
        heigh = 20;
    }
    return heigh;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headerView = nil;
//    if (section == 0) {
//        headerView.hidden = YES;
//    }
//    return headerView;
//}

#pragma mark - tableVIew delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self setNavigationBarColor:scrollView];
    [self setTopViewFrame:scrollView];
}
-(void)loadMoreStoryId{
    [self footresh];
    NSLog(@"ID---gogogo");
}
#pragma mark - 一些方法
/**
 *  设置导航栏 滑动颜色变化
 */
-(void)setNavigationBarColor:(UIScrollView *)scrollView{
    UIColor *color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY =  scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 -offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    }else{
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}
/**
 *  下拉放大
 */
-(void)setTopViewFrame:(UIScrollView *)scrollView{
    // 向下拽了多少距离
    CGFloat down = -(topViewH * 0.5) - scrollView.contentOffset.y -64;
//    NSLog(@"%f",down);
    if (down < 0) return;
    if (down > 64) {
        return;
    };
    CGRect frame = self.zoom.frame;
    // 5决定图片变大的速度,值越大,速度越快
    frame.size.height = topViewH + down * 2;
    self.zoom.frame = frame;
    

}
/**
 *  上拉刷新
 */
-(void)footresh{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        [self loadOldNews];
    });
}
-(void)dealloc{
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
