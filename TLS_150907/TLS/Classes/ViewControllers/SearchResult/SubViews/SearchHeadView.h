//
//  SearchHeadView.h
//  TLS
//
//  Created by 屠淋 on 15/8/23.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchHeadViewDelegate <NSObject>

- (void)headButtonAction:(UIButton*)button;

@end

@interface SearchHeadView : UIView


@property (nonatomic, assign) id<SearchHeadViewDelegate>delegate;

- (void)initWithArray:(NSArray*)array andFrame:(CGRect)frame;


@end
