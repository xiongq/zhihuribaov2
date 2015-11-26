//
//  btnbadgevalue.m
//  BTN角标
//
//  Created by xiong on 15/11/26.
//  Copyright © 2015年 xiong. All rights reserved.
//

#import "btnbadgevalue.h"

@implementation btnbadgevalue

-(void)setNomoreimage:(NSString *)NormlImage HightImage:(NSString *)HightImage{
    /**
     *  设置高亮正常状态的背景，为了能显示badgevalue，后续设置其选中
     *  xodo
     */
    [self setBackgroundImage:[UIImage imageNamed:HightImage] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageNamed:NormlImage] forState:UIControlStateNormal];
    
}
-(void)setNomoreimage:(NSString *)NormlImage HightImage:(NSString *)HightImage title:(NSString *)title{
    /**
     *  设置高亮正常状态的背景，为了能显示badgevalue，后续设置其选中
     *  xodo
     */
    [self setBackgroundImage:[UIImage imageNamed:HightImage] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageNamed:NormlImage] forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
}
-(void)setTitileOrigintitleX:(CGFloat)titleX titleY:(CGFloat)titleY {
   
    /**
     *  设置文字位置
     *
     *  @param titleY 距离上
     *  @param titleX 距离左
     *  @param 0      默认
     *  @param 0      默认
     */
  
    
//    self.titleLabel.backgroundColor = [UIColor redColor];
    self.titleEdgeInsets          = UIEdgeInsetsMake(titleY, titleX, 0, 0);

    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    self.titleLabel.textColor     = [UIColor whiteColor];
    self.titleLabel.font          = [UIFont systemFontOfSize:9];
}

-(void)AnimationStat:(BOOL)start{
    if (start) {
        //xodo 开始动画
    }else{
        //xodo 结束动画
    }

}
@end
