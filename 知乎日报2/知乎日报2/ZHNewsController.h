//
//  ZHNewsController.h
//  知乎日报2
//
//  Created by xiong on 15/11/23.
//  Copyright © 2015年 xiong. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol loadMoreStoryIDDelegate <NSObject>

@optional
-(void)loadMoreStoryId;

@end

@interface ZHNewsController : UIViewController

@property (nonatomic, weak) id<loadMoreStoryIDDelegate> delegate;

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) NSMutableArray *storys;
@end
