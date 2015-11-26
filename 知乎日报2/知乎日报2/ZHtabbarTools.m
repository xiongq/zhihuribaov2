//
//  ZHtabbarTools.m
//  知乎日报2
//
//  Created by xiong on 15/11/24.
//  Copyright © 2015年 xiong. All rights reserved.
//

#import "ZHtabbarTools.h"
//#import "btnbadgevalue.h"

@implementation ZHtabbarTools

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    [self setBtnType:btnBack   image:@"News_Navigation_Arrow"   hightImage:@"News_Navigation_Arrow_Highlight" list:1];
    [self setBtnType:btnNext   image:@"News_Navigation_Next"    hightImage:@"News_Navigation_Next_Highlight"  list:2];
    [self setBtnType:btnSuppot image:@"News_Navigation_Vote"    hightImage:@"News_Navigation_Voted"           list:3];
    [self setBtnType:btnShare  image:@"News_Navigation_Share"   hightImage:@"News_Navigation_Share_Highlight" list:4];
    [self setBtnType:btnLong   image:@"News_Navigation_Comment" hightImage:@"News_Navigation_Comment_Highlight" list:5];
    return self;
   
}
-(void)setBtnType:(BtnSenderTYPE)type image:(NSString *)image hightImage:(NSString *)hightImage list:(NSInteger)list{
    CGFloat btnW = self.frame.size.width/5;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnX = btnW * list - btnW;
    CGFloat btnY = 0;
    
    btnbadgevalue *btn = [[btnbadgevalue alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
    btn.tag = type;
    [btn setNomoreimage:image HightImage:hightImage];
    //    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
//    
//    [btn setImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(btnSEND:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnSEND:(btnbadgevalue *)btn{
//    UIButton *btn  = sender;
//    switch (btn.tag) {
//        case btnBack:
//            NSLog(@"ok");
//            break;
//            
//        default:
//            break;
//    }

    
    /**
     *  委托方法
     *
     *  如果delegate响应了该方法，那么就传递点击的案件
     *
     *
     */
    if ([self.delegate respondsToSelector:@selector(Btn:selectbtn:)]) {
        [self.delegate Btn:btn selectbtn:(BtnSenderTYPE)btn.tag];
    }
}

@end
