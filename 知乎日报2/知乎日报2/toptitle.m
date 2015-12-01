//
//  toptitle.m
//  知乎日报2
//
//  Created by xiong on 15/11/26.
//  Copyright © 2015年 xiong. All rights reserved.
//

#import "toptitle.h"

@implementation toptitle
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;
    
//    [self bringSubviewToFront:self.titleLabel];
    
    return self;
}


@end
