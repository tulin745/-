//
//  ToolResultCell.m
//  TLS
//
//  Created by 屠淋 on 15/8/24.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "ToolResultCell.h"

@implementation ToolResultCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.width.constant = SCREEN_WIDTH / 2.2;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
