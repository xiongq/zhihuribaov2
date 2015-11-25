//
//  ZHstoryModel.m
//  知乎日报2
//
//  Created by xiong on 15/11/20.
//  Copyright © 2015年 xiong. All rights reserved.
//

#import "ZHstoryModel.h"
#import "MJExtension.h"


@implementation ZHstoryModel


+ (NSDictionary *)objectClassInArray{
    return @{@"stories" : [Stories class], @"top_stories" : [Top_Stories class]};
}
@end
@implementation Stories

@end


@implementation Top_Stories

@end


