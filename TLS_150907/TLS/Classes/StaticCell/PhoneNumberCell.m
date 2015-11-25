//
//  phoneNumberCell.m
//  TLS
//
//  Created by 屠淋 on 15/8/8.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "PhoneNumberCell.h"

@implementation PhoneNumberCell

- (void)awakeFromNib{
    [super awakeFromNib];
    
    if (SCREEN_WIDTH != 320) {
        self.getVerCodeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        self.buttonConstraint.constant = 135;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
