//
//  ZHstoryImages.m
//  知乎日报2
//
//  Created by xiong on 15/11/24.
//  Copyright © 2015年 xiong. All rights reserved.
//

#import "ZHstoryImages.h"
#import <UIImageView+WebCache.h>
#import "UIView+Extension.h"

@implementation ZHstoryImages

-(instancetype)initWithFrame:(CGRect)frame{
    self  =   [super initWithFrame:frame];
    //顶图
    
    UIImageView *storyImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    storyImage.contentMode        = UIViewContentModeScaleAspectFill;
    storyImage.clipsToBounds      = YES;
    [self addSubview:storyImage];
    CGFloat ImageHeight = storyImage.height;
    self.storyImage = storyImage;
    //标题
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, ImageHeight - 80, frame.size.width - 30, 60)];
    title.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:21];
    title.textColor = [UIColor whiteColor];
    title.numberOfLines = 0;
    
    //蒙版
    UIColor *alpha = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    UIView *shadowView =  [UIView new];
    shadowView.frame = storyImage.frame;
    shadowView.backgroundColor = alpha;
    [storyImage addSubview:shadowView];
    [storyImage addSubview:title];
    self.title = title;
    
    //来源
    UILabel *souce = [[UILabel alloc] initWithFrame:CGRectMake(15, ImageHeight - 22, frame.size.width - 30, 30)];
    souce.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:9];
    souce.textColor = [UIColor lightTextColor];
    souce.textAlignment = NSTextAlignmentRight;
    [storyImage addSubview:souce];
    self.souce = souce;
    return self;
}

@end
