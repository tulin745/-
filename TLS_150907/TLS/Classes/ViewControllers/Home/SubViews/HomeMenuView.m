//
//  HomeMenuView.m
//  CRM
//
//  Created by mac os on 14-12-29.
//  Copyright (c) 2014年 wei. All rights reserved.
//

#import "HomeMenuView.h"

@interface HomeMenuView()


@end
@implementation HomeMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imageV = [[UIImageView alloc]init];
//        imageV.backgroundColor = ThemeColor;
        self.imageV = imageV;
        [self addSubview:imageV];
        
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        self.label = label;
        [self addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        self.bgButton = button;
        [self addSubview:button];
        
       
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.bgButton.frame = self.bounds;
    self.imageV.frame = CGRectMake(self.width / 4 , 20, self.width / 2, self.height / 2);
    self.label.frame = CGRectMake(0, self.imageV.bottom + 10, self.width, 30);
   
}


@end