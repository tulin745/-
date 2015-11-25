//
//  UIView+AlertInfo.h
//  MicrobialSystem
//
//  Created by xun on 14-8-7.
//  Copyright (c) 2014年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

#define mErrorTimeOut 2.0
#define mGlobleCheckMsgTime 1.5

typedef void(^ConfirmBlock)();

@interface UIView (AlertInfo)

@property (nonatomic, copy) ConfirmBlock  cfm;

- (void)showProgressHUDWithInfo:(NSString *)info;
- (void)showErrorMessageHUDWithInfo:(NSString *)info;
- (void)hiddenProgressHUD;

- (void)showGlobleProgressHUDWithInfo:(UIViewController *)controller withMessage:(NSString *)info;
- (void)showGlobleErrorMessageHUDWithInfo:(UIViewController *)controller withMessage:(NSString *)info;
- (void)hiddenGlobleProgressHUD:(UIViewController *)controller;

- (void)showGlobleCheckHUDWithInfo:(UIViewController *)controller withMessage:(NSString *)info;//打对勾

- (void)showGlobleAlertInfo:(UIViewController *)controller withMessage:(NSString *)info title:(NSString *)title timeout:(NSTimeInterval)time;

- (void)showConfirmMessage:(NSString *)msg;
- (void)showResultMessage:(NSString *)msg timeout:(NSTimeInterval)time;
- (void)showAlertInfo:(NSString *)info title:(NSString *)title timeout:(NSTimeInterval)time;
- (void)showChooseConfirmMessage:(NSString *)msg title:(NSString *)title confirm:(NSString *)firm cancel:(NSString *)can comfirmBlock:(ConfirmBlock)anCfm;

- (void)showActionSheetWithTitle:(NSString *)title confirmBlock:(ConfirmBlock)anCfm;

- (void)showPhotoTextViewWithText:(NSString *)text;//图文显示
- (void)hiddenPhotoTextView;

- (void)showNetWorkErrorView;
- (void)hiddenNetWorkErrorView;

- (void)showLoginPopupViewComfirBlock:(ConfirmBlock)anCfm;

- (void)beginRefresh;
- (void)endRefresh;

- (void)alertViewShowWithMessage:(NSString *)message View:(UIView*)superView;

- (BOOL)connectNetWork;

- (void)showMessageHUD:(NSString *)msg timeout:(NSTimeInterval)time;

- (UIViewController*)viewController;

@end
