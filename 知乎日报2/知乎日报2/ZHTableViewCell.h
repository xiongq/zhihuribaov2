//
//  ZHTableViewCell.h
//  知乎日报2
//
//  Created by xiong on 15/11/20.
//  Copyright © 2015年 xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel     *titile;
@property (strong, nonatomic) UIImageView          *mutile;

@end
