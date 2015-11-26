//
//  ViewController.m
//  BTN角标
//
//  Created by xiong on 15/11/26.
//  Copyright © 2015年 xiong. All rights reserved.
//

#import "ViewController.h"
#import "btnbadgevalue.h"
#import "UIView+Extension.h"
@interface ViewController ()
@property (weak, nonatomic) btnbadgevalue *btns;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIView
    btnbadgevalue *btn = [[btnbadgevalue alloc] initWithFrame:CGRectMake(0, 0, 64, 43)];
    btn.badgeValue = @"99";
//    [btn setNomoreimage:@"News_Navigation_Comment" HightImage:@"News_Navigation_Comment_Highlight"];
    [btn setNomoreimage:@"News_Navigation_Comment" HightImage:@"News_Navigation_Comment_Highlight" title:btn.badgeValue];
    btn.center = self.view.center;
    [btn setTitileOrigintitleX:19 titleY:-17];
//
//    btn.center =self.view.center;
//    [btn setTitle:@"1233" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn.titleLabel setFont:[UIFont fontWithName: @"STHeitiSC-Medium" size:7]];
//    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
////    UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
//    btn.titleEdgeInsets = UIEdgeInsetsMake(-17 , 18, 0, 0);
    [self.view addSubview:btn];
    self.btns = btn;

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.btns.badgeValue = @"1000";
    [self.btns setTitle:self.btns.badgeValue forState:UIControlStateNormal];
    NSLog(@"1111111");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
