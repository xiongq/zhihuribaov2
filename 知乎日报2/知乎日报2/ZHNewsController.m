//
//  ZHNewsController.m
//  知乎日报2
//
//  Created by xiong on 15/11/23.
//  Copyright © 2015年 xiong. All rights reserved.
//

#import "ZHNewsController.h"
#import "afnGETPOST.h"
#import "ZHNewsModel.h"
#import "MJExtension.h"
#import <UIImageView+WebCache.h>
#import "ZHstoryImages.h"
#import "ZHtabbarTools.h"
#import "UIView+Extension.h"
#import "ZHstoryModel.h"
#import "ZHLongComments.h"


//#define CGFloat topviewhww 350;
const CGFloat topviewhw = 350;
@interface ZHNewsController ()<UIScrollViewDelegate,UIWebViewDelegate,ZHtabbarToolsDelegate>
@property (strong, nonatomic)  UIWebView *news;
@property (strong, nonatomic)  ZHstoryImages *storyImage;
@property (weak, nonatomic)     UIView *shadow;
@property (strong, nonatomic)     UIView *loading;
@property (strong, nonatomic)   UILabel *load;
@property (strong, nonatomic)     ZHtabbarTools *tools;

@end

@implementation ZHNewsController
{
    NSInteger index;
    
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

-(ZHtabbarTools *)tools{
    if (!_tools) {
        self.tools = [[ZHtabbarTools alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
        /**
         *  工具栏的被委托者就是当前控制器
         */
        self.tools.tag = 2000;
        self.tools.delegate = self;
    }
    return _tools;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    index = 0;
    if (self.row == self.storys.count - 1) {
        [self.delegate loadMoreStoryId];
    }
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.view.clipsToBounds = YES;
    //webview---------------------------------------------------------------------------------
    self.news = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.news];
    self.news.delegate = self;
    self.news.scrollView.delegate = self;
    self.news.backgroundColor = [UIColor whiteColor];
//    [self loadNews:self.id];
    if (self.id != 0) {
        [self QueueRequestHttps:self.id];
    }
    
    

 
    
    //状态栏遮挡---------------------------------------------------------------------------------
    UIView *shadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    shadow.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shadow];
    shadow.hidden = YES;
    self.shadow = shadow;
    
    //loading遮挡---------------------------------------------------------------------------------
    self.loading = [UIView new];
    self.loading.backgroundColor = [UIColor whiteColor];
    self.loading.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44);
    self.load = [UILabel new];
    self.load.width = 100;
    self.load.height = 40;
    self.load.center = self.loading.center;
    self.load.text  = @"loading";
    self.load.textAlignment = NSTextAlignmentCenter;
    self.load.textColor = [UIColor blackColor];
    [self.view addSubview:self.loading];
    [self.loading addSubview:self.load];
//    [self.view addSubview:[self addToolsBar]];
//    self.tools.hidden = NO;
}
-(void)addToolsBar{
    //底部工具栏
    self.tools = [[ZHtabbarTools alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
    /**
     *  工具栏的被委托者就是当前控制器
     */
    self.tools.tag = 2000;
    self.tools.delegate = self;
    [self.view addSubview:self.tools];

}


/**
 *  点击加载下一个
 *  xodo 数组越界+传过来的模型数据有限-写委托继续加载
 */
-(void)loadNextNewsrow:(NSInteger)row{
    self.tools.hidden = NO;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    [self.news loadHTMLString:@"<html></html>" baseURL:nil];

    [self CGAnimation];
    NSLog(@"row-------%ld",(long)row);
    index += 1;
    if ((row + index) > self.storys.count -2) {
        NSLog(@"超过了");
       [self.delegate loadMoreStoryId];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test) name:@"complete" object:nil];
    Stories *test = [self.storys objectAtIndex:(row + index)];
    NSLog(@"testid-------%ld",test.id);
    NSLog(@"count-------%lu",(unsigned long)self.storys.count);
//    [self loadNews:test.id];
    [self QueueRequestHttps:test.id];
    /**
     *  加载more id
     */
//    if ([self.delegate respondsToSelector:@selector(loadMoreStoryId)]) {
//        [self.delegate loadMoreStoryId];
//    }
}
-(void)test{
    NSLog(@"1231212");

}

#pragma mark - 转场动画
/**
 *  下一章动画
 */
-(void)CGAnimation{
    CGAffineTransform offsetUP   =  CGAffineTransformMakeTranslation(0, -self.view.frame.size.height);
    CGAffineTransform offsetDOWN =  CGAffineTransformMakeTranslation(0, self.view.frame.size.height);
    ZHNewsController *Tonewsvc = [self.storyboard instantiateViewControllerWithIdentifier:@"webview"];
    UIView *toview = Tonewsvc.view;
    toview.frame = self.view.frame;
    UIView *fromview = [self.view snapshotViewAfterScreenUpdates:NO];
//    CGRect rect = CGRectMake(0, 0, self.view.width, self.view.height- 44);
//    UIEdgeInsets edge = UIEdgeInsetsMake(0, 0, 44, 0);
//    UIView *fromview = [self.view resizableSnapshotViewFromRect:rect afterScreenUpdates:YES withCapInsets:edge];
    [self.view addSubview:fromview];
    toview.transform = offsetUP;
    
  
    [self addChildViewController:Tonewsvc];
    [UIView animateWithDuration:0.5 animations:^{
        [self.storyImage removeFromSuperview];

        
        fromview.transform = offsetUP;
//        toview.transform = offsetDOWN;
          [self.view addSubview:toview];
        
    } completion:^(BOOL finished) {

        for (int i = 0 ; i < self.view.subviews.count; i++) {
            UIView *test = [self.view.subviews objectAtIndex:i];
//            NSLog(@"%@",test);
            if (test.frame.origin.y < 0) {
                [test removeFromSuperview];
            }
//
        }
        NSLog(@"from----%lu",(unsigned long)self.view.subviews.count);
    }];
}
/**
 *  设置顶部数据源
 */
-(void)setIMAGE:(ZHNewsModel *)model{
    self.storyImage = [[ZHstoryImages alloc] initWithFrame:CGRectMake(0, -131, self.view.frame.size.width, topviewhw)];
    self.storyImage.backgroundColor = [UIColor grayColor];
    self.storyImage.souce.text = [NSString stringWithFormat:@"图片:%@",model.image_source];
    self.storyImage.title.text = model.title;
    [self.storyImage.storyImage sd_setImageWithURL:[NSURL URLWithString:model.image]];
    [self.news.scrollView addSubview:self.storyImage];
}
#pragma mark - 实现工具栏委托方法

-(void)Btn:(btnbadgevalue *)btn selectbtn:(BtnSenderTYPE)btntype{
    switch (btntype) {
        case btnBack:
            
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case btnNext:
            [self.news stopLoading];
           [self loadNextNewsrow:self.row];
            break;
        case btnSuppot:
            break;
        case btnShare:
            break;
        case btnLong:
            [btn setTitle:@"1238" forState:UIControlStateNormal];
            [btn setTitileOrigintitleX:20 titleY:-17];
            break;

    }
}

#pragma mark - 加载新闻-网络请求
-(void)loadNews:(NSInteger)ID{
//    [self.view addSubview:self.tools];
//    if (ID == 0)return;
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];
//
////    api https://news-at.zhihu.com/api/4/news/id
//    NSString *url = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/news/%ld",(long)ID];
//
//    [afnGETPOST GETURL:url prames:nil success:^(id json) {
//        ZHNewsModel *model = [ZHNewsModel mj_objectWithKeyValues:json];
//        NSURL *css = [NSURL URLWithString:[model.css firstObject]];
//        NSString *new = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href= %@ </head><body>%@</body></html>",css,model.body];
//        [self.news loadHTMLString:new baseURL:nil];
//        self.news.scrollView.contentInset = UIEdgeInsetsMake(20, 0, 20, 0);
//        self.loading.hidden = YES;
//
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self setIMAGE:model];
//        });
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//        self.loading.hidden = NO;
//        self.load.text = @"网络超时，点击重新加载";
//    }];
////     https://news-at.zhihu.com/api/4/story-extra/#id
//    NSString *comments = [NSString stringWithFormat:@" https://news-at.zhihu.com/api/4/story-extra/#%ld",(long)ID];
//    [afnGETPOST GETURL:comments prames:nil success:^(id json) {
//        NSLog(@"%@",json);
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
}
/**
 *  队列请求
 */
-(void)QueueRequestHttps:(NSInteger) ID{
    [self.view addSubview:self.tools];
//    if (ID == 0)return;
    
    
    NSURLRequest *storysUrl = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/news/%ld",(long)ID]]];
//    http://news-at.zhihu.com/api/4/story-extra/7496816
     NSURLRequest *storyCommitUrl = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/story-extra/%ld",(long)ID]]];
    
    AFHTTPRequestOperation *QueueRequset1 = [[AFHTTPRequestOperation alloc] initWithRequest:storysUrl];
    [QueueRequset1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        ZHNewsModel *model = [ZHNewsModel mj_objectWithKeyValues:responseObject];
        NSURL *css = [NSURL URLWithString:[model.css firstObject]];
        NSString *new = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href= %@ </head><body>%@</body></html>",css,model.body];
        [self.news loadHTMLString:new baseURL:nil];
        self.news.scrollView.contentInset = UIEdgeInsetsMake(20, 0, 20, 0);
        self.loading.hidden = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setIMAGE:model];
        });
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"详情-------%@",error);
        self.loading.hidden = NO;
        self.load.text = @"网络超时，点击重新加载";
    }];
    
    
     AFHTTPRequestOperation *QueueRequset2 = [[AFHTTPRequestOperation alloc] initWithRequest:storyCommitUrl];
    [QueueRequset2 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        ZHLongComments *model = [ZHLongComments mj_objectWithKeyValues:responseObject];
         NSLog(@"%ld",(long)model.popularity);
        for (btnbadgevalue *btn in self.tools.subviews) {
            NSString *suppotK = [NSString new];
            if (btn.tag == btnSuppot) {
                if (model.popularity > 1000) {
                    float suppot = model.popularity/1000;
                   suppotK = [NSString stringWithFormat:@"%.0fK",suppot];
                }else{
                    suppotK = [NSString stringWithFormat:@"%ld", model.popularity];
                }
                [btn setTitle:suppotK forState:UIControlStateNormal];
                [btn setTitileOrigintitleX:22 titleY:-17];
                
                UIColor *titleRGB = [UIColor colorWithRed:32.0/255 green:180.0/255  blue:241.0/255 alpha:1];
                [btn setTitleColor:titleRGB forState:UIControlStateNormal];
            }else if (btn.tag == btnLong){
                [btn setTitle:[NSString stringWithFormat:@"%ld", model.comments] forState:UIControlStateNormal];
                [btn setTitileOrigintitleX:22 titleY:-17];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"评论------%@",error);
    }];
    
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.maxConcurrentOperationCount = 2;
    [queue addOperations:@[QueueRequset1,QueueRequset2] waitUntilFinished:YES];
}
#pragma mark - UIWebView代理
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//     NSURLRequest *res = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urls]];
 
    NSString *ss = [NSString stringWithFormat:@"%@",request.URL];
    /**
     *  这个地方处理点击文章链接跳转，顶图不消失
     */
    if ([ss isEqualToString:@"about:blank"]) {
        self.storyImage.hidden = NO;
    }else {
        self.storyImage.hidden = YES;
    }

    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
  
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
//     [[NSURLCache sharedURLCache] removeAllCachedResponses];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    [self.news stopLoading];
}

#pragma mark - scrollView代理
/**
 *  webview滑动一段距离之后状态栏颜色
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat offsetDo= topviewhw + self.storyImage.frame.origin.y -20;
    if (offsetY >= offsetDo) {
        self.shadow.hidden = NO;
    }else{
        self.shadow.hidden = YES;
    }

}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.news.delegate = nil;
    [self.news stopLoading ];
    self.news = nil;
}
@end
