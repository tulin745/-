//
//  UIView+AlertInfo.m
//  MicrobialSystem
//
//  Created by xun on 14-8-7.
//  Copyright (c) 2014年 Lee. All rights reserved.
//

#import "UIView+AlertInfo.h"

#import "TAlertView.h"

#import "MBProgressHUD.h"
#import <objc/runtime.h>

static char const *const kConfirmKey = "AlertInfoConfirmKey";

@implementation UIView (AlertInfo) 
@dynamic cfm;

- (ConfirmBlock)cfm
{
    return objc_getAssociatedObject(self, kConfirmKey);
}

- (void)setCfm:(ConfirmBlock)cfm
{
    objc_setAssociatedObject(self, kConfirmKey, cfm, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)showProgressHUDWithInfo:(NSString *)info{
    [self endEditing:YES];
    MBProgressHUD *hud = nil;
    if (!hud) {
        hud = [[MBProgressHUD alloc] initWithView:self];
        hud.labelColor = [UIColor lightGrayColor];
        hud.activityIndicatorColor = [UIColor blackColor];
        hud.color = [UIColor clearColor];
        [hud setOpacity:0.8];
        [hud setYOffset:-30];
        [self addSubview:hud];
    }
    [hud setLabelText:[info length]?info:@"加载数据中..."];
    [hud show:YES];
}

- (void)showErrorMessageHUDWithInfo:(NSString *)info
{
    MBProgressHUD *hud = nil;
    if (!hud) {
        hud = [[MBProgressHUD alloc] initWithView:self];
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-facemark.png"]];
        hud.mode = MBProgressHUDModeCustomView;
//        hud.dimBackground = YES;
        [hud setOpacity:0.8];
        [hud setYOffset:-30];
        [self addSubview:hud];
    }
    [hud setLabelText:[info length]?info:@"加载数据出错!"];
    [hud show:YES];
    [self performSelector:@selector(hiddenProgressHUD) withObject:nil afterDelay:mErrorTimeOut];
}

- (void)hiddenProgressHUD{
    for (UIView *vv in [self subviews]) {
        if ([vv isKindOfClass:[MBProgressHUD class]]) {
            [(MBProgressHUD *)vv hide:YES];
            [vv removeFromSuperview];
            break;
        }
    }
}

- (void)showGlobleProgressHUDWithInfo:(UIViewController *)controller withMessage:(NSString *)info{
    [self endEditing:YES];
    MBProgressHUD *hud = nil;
    if (!hud) {
        //UIViewController *control = mApplicationDelegate.window.rootViewController;
        hud = [[MBProgressHUD alloc] initWithView:controller.view];
        hud.labelColor = [UIColor lightGrayColor];
        [hud setOpacity:0.8];
        [hud setYOffset:20];
        [controller.view addSubview:hud];
    }
    [hud setLabelText:[info length]?info:@"加载数据中..."];
    [hud show:YES];
}

- (void)showGlobleErrorMessageHUDWithInfo:(UIViewController *)controller withMessage:(NSString *)info
{
    MBProgressHUD* hud = nil;
    if (!hud) {
        hud = [[MBProgressHUD alloc] initWithView:controller.view];
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-facemark"]];
        hud.mode = MBProgressHUDModeCustomView;
        hud.activityIndicatorColor = [UIColor blackColor];
        hud.dimBackground = YES;
        [hud setOpacity:0.8];
        [hud setYOffset:20];
        [controller.view addSubview:hud];
    }
    [hud setLabelText:[info length]?info:@"加载数据出错!"];
    [hud show:YES];
    [self performSelector:@selector(hiddenProgressHUD) withObject:nil afterDelay:mErrorTimeOut];
}

- (void)showGlobleCheckHUDWithInfo:(UIViewController *)controller withMessage:(NSString *)info
{
    MBProgressHUD* hud = nil;
    if (!hud) {
        hud = [[MBProgressHUD alloc] initWithView:controller.view];
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
        hud.mode = MBProgressHUDModeCustomView;
        hud.dimBackground = YES;
        [hud setOpacity:0.8];
        [hud setYOffset:20];
        [controller.view addSubview:hud];
    }
    [hud setLabelText:[info length]?info:@"加载成功"];
    [hud show:YES];
    [self performSelector:@selector(hiddenGlobleProgressHUD:) withObject:nil afterDelay:mErrorTimeOut];
}

- (void)hiddenGlobleProgressHUD:(UIViewController *)controller{
    
    for (UIView *vv in [controller.view subviews]) {
        if ([vv isKindOfClass:[MBProgressHUD class]]) {
            [(MBProgressHUD *)vv hide:YES];
            [vv removeFromSuperview];
            break;
        }
    }
}

- (void)showConfirmMessage:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)showMessageHUD:(NSString *)msg timeout:(NSTimeInterval)time{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, self.height/2-25, self.width-10, 50)];
    view.alpha = 0.2;
    [view setBackgroundColor:[UIColor blackColor]];
    
    UILabel *lbmsg = [[UILabel alloc] initWithFrame:view.bounds];
    [lbmsg setText:msg];
    [lbmsg setTextColor:[UIColor whiteColor]];
    [lbmsg setTextAlignment:NSTextAlignmentCenter];
    [lbmsg setBackgroundColor:[UIColor clearColor]];
    [lbmsg setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [view addSubview:lbmsg];
    [self addSubview:view];
    
    double delayInSeconds = time;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [view removeFromSuperview];
        });
}

- (void)showResultMessage:(NSString *)msg timeout:(NSTimeInterval)time{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, self.height, self.width-10, 50)];
    [view setBackgroundColor:Color_RGB(55, 173, 234)];
    
    UILabel *lbmsg = [[UILabel alloc] initWithFrame:view.bounds];
    [lbmsg setText:msg];
    [lbmsg setTextColor:[UIColor whiteColor]];
    [lbmsg setTextAlignment:NSTextAlignmentCenter];
    [lbmsg setBackgroundColor:[UIColor clearColor]];
    [lbmsg setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [view addSubview:lbmsg];
    [self addSubview:view];
    
    [UIView animateWithDuration:0.33 animations:^(void){
        [view setY:self.height - 50];
    } completion:^(BOOL finished){
        double delayInSeconds = time;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [UIView animateWithDuration:0.28 animations:^(void){
                [view setY:self.height + 50];
            } completion:^(BOOL finished){
                [view removeFromSuperview];
            }];
        });
    }];
}

- (void)showGlobleAlertInfo:(UIViewController *)controller withMessage:(NSString *)info title:(NSString *)title timeout:(NSTimeInterval)time
{
    //UIViewController *control = mApplicationDelegate.window.rootViewController;
    UIView *mainView = controller.view;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    [view.layer setCornerRadius:10.0f];
    [view setClipsToBounds:YES];
    [view setBackgroundColor:[UIColor clearColor]];
    [view setCenter:CGPointMake(mainView.centerX, mainView.centerY)];
    [view setAlpha:0.0f];
    
    UIView *bgView = [[UIView alloc] initWithFrame:view.bounds];
    [bgView setBackgroundColor:[UIColor blackColor]];
    [bgView setAlpha:1];
    [view addSubview:bgView];
    
    UILabel*lbinfo=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, view.width-20, view.height-20)];
    [lbinfo setNumberOfLines:0];
    [lbinfo setTextColor:[UIColor whiteColor]];
    [lbinfo setBackgroundColor:[UIColor clearColor]];
    [lbinfo setTextAlignment:NSTextAlignmentLeft];
    [lbinfo setFont:[UIFont systemFontOfSize:12.0f]];
    [lbinfo setText:info];
    [lbinfo sizeToFit];
    
    if (lbinfo.height > view.height - 20) {
        [view setHeight:lbinfo.height+20];
        [bgView setFrame:view.bounds];
    }
    
    [lbinfo setCenter:CGPointMake(view.centerX, view.centerY)];
    [view addSubview:lbinfo];
    float screenHeight;
    UIDevice *device = [UIDevice currentDevice];
    
    if (device.orientation == UIInterfaceOrientationPortrait || device.orientation == UIInterfaceOrientationPortraitUpsideDown){//正
            screenHeight = mainView.height;
        }   else {//反
            screenHeight =mainView.width;
        }
    [view setY:screenHeight - view.height - 60];
    [mainView addSubview:view];
    
    [UIView animateWithDuration:0.33 animations:^(void){
        [view setAlpha:1.0f];
    }completion:^(BOOL finished){
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [UIView animateWithDuration:0.33 animations:^(void){
                [view setAlpha:0.0f];
            }completion:^(BOOL finished){
                [view removeFromSuperview];
            }];
        });
    }];
}

- (void)showAlertInfo:(NSString *)info title:(NSString *)title timeout:(NSTimeInterval)time{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    [view.layer setCornerRadius:10.0f];
    [view setClipsToBounds:YES];
    [view setBackgroundColor:[UIColor clearColor]];
    [view setCenter:CGPointMake(self.centerX, self.centerY)];
    [view setAlpha:0.0f];
    
    UIView *bgView = [[UIView alloc] initWithFrame:view.bounds];
    [bgView setBackgroundColor:[UIColor blackColor]];
    [bgView setAlpha:1];
    [view addSubview:bgView];
    
    UILabel*lbinfo=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, view.width-20, view.height-20)];
    [lbinfo setNumberOfLines:0];
    [lbinfo setTextColor:[UIColor whiteColor]];
    [lbinfo setBackgroundColor:[UIColor clearColor]];
    [lbinfo setTextAlignment:NSTextAlignmentLeft];
    [lbinfo setFont:[UIFont systemFontOfSize:12.0f]];
    [lbinfo setText:info];
    [lbinfo sizeToFit];
    
    if (lbinfo.height > view.height - 20) {
        [view setHeight:lbinfo.height+20];
        [bgView setFrame:view.bounds];
    }
    
    [lbinfo setCenter:CGPointMake(view.centerX, view.centerY)];
    [view addSubview:lbinfo];
    
    [view setY:self.height - view.height - 60];
    [self addSubview:view];
    
    [UIView animateWithDuration:0.33 animations:^(void){
        [view setAlpha:1.0f];
    }completion:^(BOOL finished){
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [UIView animateWithDuration:0.33 animations:^(void){
                [view setAlpha:0.0f];
            }completion:^(BOOL finished){
                [view removeFromSuperview];
            }];
        });
    }];
}

- (void)showChooseConfirmMessage:(NSString *)msg title:(NSString *)title confirm:(NSString *)firm cancel:(NSString *)can comfirmBlock:(ConfirmBlock)anCfm{
    self.cfm = anCfm;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:firm otherButtonTitles:can, nil];
    [alert show];
}

- (void)showActionSheetWithTitle:(NSString *)title confirmBlock:(ConfirmBlock)anCfm
{
    self.cfm = anCfm;
    UIActionSheet *act = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];
    [act showInView:self];
}

- (void)showPhotoTextViewWithText:(NSString *)text
{
    UIView *photoTextView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height*0.5-50, self.width, 100)];
    photoTextView.backgroundColor = [UIColor clearColor];
    photoTextView.tag = 111000;
    photoTextView.userInteractionEnabled = YES;
    [self addSubview:photoTextView];
    
    UIImage *img = [UIImage imageNamed:@"ig_cartoon"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(photoTextView.width*0.5-img.size.width*0.5, 10, img.size.width, img.size.height)];
    [imgView setImage:img];
    [photoTextView addSubview:imgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.bottom+10, photoTextView.width, 42)];
    label.numberOfLines = 0;
    label.textColor = Color_RGB(205, 205, 205);
    label.font = [UIFont systemFontOfSize:13];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    [photoTextView addSubview:label];
}

- (void)hiddenPhotoTextView
{
    for (UIView *vv in [self subviews]) {
        if (vv.tag == 111000) {
            [vv removeFromSuperview];
            break;
        }
    }
}

- (void)showNetWorkErrorView
{
    UIView *photoTextView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height*0.5-50, self.width, 100)];
    photoTextView.backgroundColor = [UIColor clearColor];
    photoTextView.tag = 111001;
    photoTextView.userInteractionEnabled = YES;
    [self addSubview:photoTextView];
    
    UIImage *img = [UIImage imageNamed:@"ig_cartoon02"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(photoTextView.width*0.5-img.size.width*0.5, 10, img.size.width, img.size.height)];
    [imgView setImage:img];
    [photoTextView addSubview:imgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.bottom+10, photoTextView.width, 21)];
    label.textColor = Color_RGB(205, 205, 205);
    label.font = [UIFont systemFontOfSize:13];
    label.text = @"网络异常,请确认是否联网";
    label.textAlignment = NSTextAlignmentCenter;
    [photoTextView addSubview:label];
}

- (void)hiddenNetWorkErrorView
{
    for (UIView *vv in [self subviews]) {
        if (vv.tag == 111001) {
            [vv removeFromSuperview];
            break;
        }
    }
}


- (void)beginRefresh{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BeginRefresh" object:nil];
}

- (void)endRefresh{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EndRefresh" object:nil];
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (void)alertViewShowWithMessage:(NSString *)message View:(UIView*)superView{
    
    TAlertView *alertV = [[TAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [alertV initAlertWithTitle:@"Prompt" message:message andButtons:@[@"OK"]];
    [alertV showOnView:superView];
    
}

//- (BOOL)connectNetWork
//{
//    AppDelegate *delegate = (AppDelegate *)kAppDelegate;
//    NSInteger status = [delegate.reachbility currentReachabilityStatus];
//    return status;
//}

#pragma mark----------
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (!buttonIndex) {
        if (self.cfm) {
            self.cfm();
        }
    }
}

#pragma mark----------
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!buttonIndex) {
        self.cfm();
    }
}

@end
