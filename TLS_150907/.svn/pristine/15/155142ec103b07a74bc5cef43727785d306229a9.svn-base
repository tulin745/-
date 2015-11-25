//
//  SeachTextFeild.m
//  TLS
//
//  Created by 屠淋 on 15/8/13.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "SeachTextFeild.h"

@interface SeachTextFeild()

@property (nonatomic, strong) UIImageView *imageV;

@end

@implementation SeachTextFeild

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xe9e9e9);
        self.placeholder = @"What are you looking for...";
        self.layer.cornerRadius = 15;
        self.font = [UIFont systemFontOfSize:14];

        self.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 30)] ;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(2, 7.5, 15, 15)];
        imageV.image = [UIImage imageNamed:@"search"];
        [rightView addSubview:imageV];
        
        self.rightView = rightView ;
        self.rightViewMode = UITextFieldViewModeAlways;

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}
@end
