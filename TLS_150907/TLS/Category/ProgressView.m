//
//  ProgressView.m
//  TLS
//
//  Created by 屠淋 on 15/8/20.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView()

@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation ProgressView

- (UIProgressView*)progressView{
    
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]init];
        
    }
    return _progressView;
}





@end
