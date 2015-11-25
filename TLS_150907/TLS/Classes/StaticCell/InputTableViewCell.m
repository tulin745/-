//
//  InputTableViewCell.m
//  TLS
//
//  Created by 屠淋 on 15/8/8.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "InputTableViewCell.h"

@implementation InputTableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    
    
}

- (void)layoutSubviews{

    [super layoutSubviews];
    self.textFeild.secureTextEntry = self.IsPassword;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
