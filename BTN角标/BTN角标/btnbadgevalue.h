//
//  btnbadgevalue.h
//  BTN角标
//
//  Created by xiong on 15/11/26.
//  Copyright © 2015年 xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface btnbadgevalue : UIButton
@property (weak, nonatomic) NSString *badgeValue;

-(void)setNomoreimage:(NSString *)NormlImage HightImage:(NSString *)HightImage;
-(void)setNomoreimage:(NSString *)NormlImage HightImage:(NSString *)HightImage title:(NSString *)title;
-(void)setTitileOrigintitleX:(CGFloat)titleX titleY:(CGFloat)titleY;
-(void)AnimationStat:(BOOL)start;
@end
