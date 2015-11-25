//
//  TAlertView.h
//  TLS
//
//  Created by 屠淋 on 15/8/8.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TAlertView;

@protocol TAlertViewDelegate <NSObject>

- (void)TalertView:(TAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;


@end

@interface TAlertView : UIView

@property (nonatomic, assign) id<TAlertViewDelegate>delegate;

- (void)initAlertWithTitle:(NSString*)title message:(NSString *)message andButtons:(NSArray*)buttons;

- (void)showOnView:(UIView*)superView;

@end
