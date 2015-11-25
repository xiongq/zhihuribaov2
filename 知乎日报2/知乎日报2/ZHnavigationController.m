//
//  ZHnavigationController.m
//  知乎日报2
//
//  Created by xiong on 15/11/20.
//  Copyright © 2015年 xiong. All rights reserved.
//

#import "ZHnavigationController.h"

@interface ZHnavigationController ()

@end

@implementation ZHnavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /**
     *  NAVI透明
     */
//    [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    [UINavigationBar appearance].titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Evernote_Button_bg"] forBarMetrics:UIBarMetricsCompact];
//    [UINavigationBar appearance].clipsToBounds =YES;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
