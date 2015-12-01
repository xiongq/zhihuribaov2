//
//  top5.m
//  知乎日报2
//
//  Created by xiong on 15/11/26.
//  Copyright © 2015年 xiong. All rights reserved.
//

#import "top5.h"

@implementation top5

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    self.scroll.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        return self;
}

@end
