//
//  ZHTableViewCell.m
//  知乎日报2
//
//  Created by xiong on 15/11/20.
//  Copyright © 2015年 xiong. All rights reserved.
//

#import "ZHTableViewCell.h"
#import "ZHstoryModel.h"
#import "UIView+Extension.h"

@implementation ZHTableViewCell

- (void)awakeFromNib {
    self.mutile = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Home_Morepic"]];
    [self.icon addSubview:self.mutile];
    self.mutile.x = self.icon.width - self.mutile.width;
    self.mutile.y = self.icon.height - self.mutile.height;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
