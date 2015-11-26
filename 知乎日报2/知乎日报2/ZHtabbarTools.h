//
//  ZHtabbarTools.h
//  知乎日报2
//
//  Created by xiong on 15/11/24.
//  Copyright © 2015年 xiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "btnbadgevalue.h"


typedef enum BtnSender{
    btnBack,   /* 返回列表**/
    btnNext,   /* 下一个故事**/
    btnSuppot, /* 赞**/
    btnShare,  /* 分享**/
    btnLong    /* 长评数量**/
}BtnSenderTYPE;
/**
 *  创建一个委托协议，必须实现该控件的delegate（uiview 继承nsobject）
 */
@protocol ZHtabbarToolsDelegate <NSObject>
/**
 *  声明委托方法，得在m文件实现
 */
@optional
-(void)Btn:(btnbadgevalue *)btn selectbtn:(BtnSenderTYPE)btntype;

@end

@interface ZHtabbarTools : UIView
/**
 *  声明委托
 */
@property (weak, nonatomic) id<ZHtabbarToolsDelegate> delegate;
@end
