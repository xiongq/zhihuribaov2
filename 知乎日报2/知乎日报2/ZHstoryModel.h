//
//  ZHstoryModel.h
//  知乎日报2
//
//  Created by xiong on 15/11/20.
//  Copyright © 2015年 xiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Stories,Top_Stories;
@interface ZHstoryModel : NSObject

@property (nonatomic, copy) NSString *date;

@property (nonatomic, strong) NSArray<Stories *> *stories;

@property (nonatomic, strong) NSArray<Top_Stories *> *top_stories;


@end
@interface Stories : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSArray<NSString *> *images;

@property (nonatomic, copy) NSString *ga_prefix;

@property (nonatomic, assign ) NSInteger multipic;


@end

@interface Top_Stories : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *ga_prefix;

@end

