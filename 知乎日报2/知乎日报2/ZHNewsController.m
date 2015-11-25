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


const CGFloat topViewH = 350;

@interface ZHNewsController ()<UIScrollViewDelegate,UIWebViewDelegate,ZHtabbarToolsDelegate>
@property (strong, nonatomic)  UIWebView *news;
@property (strong, nonatomic)  ZHstoryImages *storyImage;
@property (weak, nonatomic)     UIView *shadow;
@property (strong, nonatomic)     UIView *loading;
@property (strong, nonatomic)   UILabel *load;

@end

@implementation ZHNewsController
{
    NSInteger index;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    index = 0;
    NSLog(@"%ld",(long)self.row);
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.view.clipsToBounds = YES;
    self.news = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.news];
    self.news.delegate = self;
    self.news.scrollView.delegate = self;
    self.news.backgroundColor = [UIColor whiteColor];
    [self loadNews:self.id];
    
    //底部工具栏
    ZHtabbarTools *tools = [[ZHtabbarTools alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
    /**
     *  工具栏的被委托者就是当前控制器
     */
    tools.delegate = self;
    [self.view addSubview:tools];
    
    //状态栏遮挡
    
    UIView *shadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    shadow.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shadow];
    shadow.hidden = YES;
    self.shadow = shadow;
//    self.test = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    self.test.center = self.news.center;
//    self.test.width = self.test.height = 150;
    self.loading = [UIView new];
    self.loading.backgroundColor = [UIColor whiteColor];
    self.loading.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    [self.loading  addSubview:self.test];
    [self.view addSubview:self.loading];
    self.load = [UILabel new];
    self.load.width = 100;
    self.load.height = 40;
    self.load.center = self.loading.center;
    self.load.text  = @"loading";
    self.load.textColor = [UIColor blackColor];
    [self.loading addSubview:self.load];
}
/**
 *  实现工具栏委托方法
 */
-(void)Btn:(UIButton *)btn selectbtn:(BtnSenderTYPE)btntype{
    switch (btntype) {
        case btnBack:
            
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case btnNext:
            
            [self loadNextNewsrow:self.row];
            break;
        default:
            break;
    }
}
/**
 *  点击加载下一个
 *  xodo 数组越界+传过来的模型数据有限-写委托继续加载
 */
-(void)loadNextNewsrow:(NSInteger)row{
    NSLog(@"%ld",(long)row);
    index += 1;
    Stories *test = [self.storys objectAtIndex:(row + index)];
    NSLog(@"%ld",test.id);
    [self loadNews:test.id];
    
}
/**
 *  设置顶部数据源
 */
-(void)setIMAGE:(ZHNewsModel *)model{
    self.storyImage = [[ZHstoryImages alloc] initWithFrame:CGRectMake(0, -131, self.view.frame.size.width, topViewH)];
    self.storyImage.backgroundColor = [UIColor grayColor];
    self.storyImage.souce.text = [NSString stringWithFormat:@"图片:%@",model.image_source];
    self.storyImage.title.text = model.title;
    [self.storyImage.storyImage sd_setImageWithURL:[NSURL URLWithString:model.image]];
    [self.news.scrollView addSubview:self.storyImage];
}
-(void)loadNews:(NSInteger)ID{
    self.loading.hidden = NO;

//    api https://news-at.zhihu.com/api/4/news/id
    NSString *url = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/news/%ld",(long)ID];

    [afnGETPOST GETURL:url prames:nil success:^(id json) {
        ZHNewsModel *model = [ZHNewsModel mj_objectWithKeyValues:json];
        NSURL *css = [NSURL URLWithString:[model.css firstObject]];
        NSString *new = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href= %@ </head><body>%@</body></html>",css,model.body];
        [self.news loadHTMLString:new baseURL:nil];
        self.news.scrollView.contentInset = UIEdgeInsetsMake(20, 0, 20, 0);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setIMAGE:model];
            self.loading.hidden = YES;
            
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        self.loading.hidden = NO;
        self.load.text = @"网络超时，点击重新加载";
    }];
    
}
#pragma make uiwebviewdelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//     NSURLRequest *res = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urls]];
 
    NSString *ss = [NSString stringWithFormat:@"%@",request.URL];
    
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
    
   
//    [self.loading removeFromSuperview];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat offsetDo= topViewH + self.storyImage.frame.origin.y -20;
    if (offsetY >= offsetDo) {
        self.shadow.hidden = NO;
    }else{
        self.shadow.hidden = YES;
    }

}

@end
