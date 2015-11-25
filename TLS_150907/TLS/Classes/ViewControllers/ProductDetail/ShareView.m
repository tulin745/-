//
//  ShareView.m
//  TLS
//
//  Created by 屠淋 on 15/8/23.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "ShareView.h"
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@interface ShareView()<FBSDKSharingDelegate>

@property (nonatomic, strong) UIView *footView;

@end

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBACOLOR(0, 0, 0,0);
        self.hidden = YES;
        
         UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 120)];
        footView.backgroundColor = [UIColor whiteColor];
        [self addSubview:footView];
        self.footView = footView;
        
        UIButton *facebookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [facebookBtn setBackgroundImage:[UIImage imageNamed:@"facebook"] forState:UIControlStateNormal];
        facebookBtn.frame = CGRectMake(20, 15, 46, 42);
        [facebookBtn addTarget:self action:@selector(facebookAction:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:facebookBtn];
        
//        FBSDKShareLinkContent * content  = [[FBSDKShareLinkContent alloc]init];
//        
//        content.contentURL = [NSURL URLWithString:@"http://www.baidu.com"];
//        
//        FBSDKShareButton *faceBook = [[FBSDKShareButton alloc] init];
//        faceBook.shareContent = content;
//        faceBook.frame = CGRectMake(20, 15, 80, 42);
//        [footView addSubview:faceBook];
        
        
        UIButton *twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [twitterButton setBackgroundImage:[UIImage imageNamed:@"share-2"] forState:UIControlStateNormal];
        twitterButton.frame = CGRectMake(facebookBtn.right + 20, 15, 46, 42);
        [twitterButton addTarget:self action:@selector(twitterAction:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:twitterButton];
        

        

    }
    return self;
}

- (void)facebookAction:(UIButton*)btn{

    FBSDKShareDialog *shareDialog = [self getShareDialogWithContentURL:[NSURL URLWithString:@"http://shareitexampleapp.parseapp.com/goofy/"]];
    shareDialog.delegate = self;
    [shareDialog show];
    
}

- (FBSDKShareLinkContent *)getShareLinkContentWithContentURL:(NSURL *)objectURL
{
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = objectURL;
    return content;
}

- (FBSDKShareDialog *)getShareDialogWithContentURL:(NSURL *)objectURL
{
    FBSDKShareDialog *shareDialog = [[FBSDKShareDialog alloc] init];
    shareDialog.shareContent = [self getShareLinkContentWithContentURL:objectURL];
    return shareDialog;
}

- (void)twitterAction:(UIButton*)btn{
    

}


- (void)showShareView{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.footView.frame = CGRectMake(0, SCREEN_HEIGHT - 120, SCREEN_WIDTH, 120);
         self.backgroundColor = RGBACOLOR(0, 0, 0, 0.3);
        self.hidden = NO;
//        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    }];
    
}

- (void)hiddenShareView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.hidden = YES;
        self.backgroundColor = RGBACOLOR(0, 0, 0, 0);
        self.footView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 120);
//        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);

    }];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    UIView *view = touch.view;
    
    if(view != self.footView){
        [self hiddenShareView];

    }

}

- (void)faceBookShare{

    FBSDKShareLinkContent * content  = [[FBSDKShareLinkContent alloc]init];
    
    content.contentURL = [NSURL URLWithString:@"http://www.baidu.com"];
    
    FBSDKShareButton *button = [[FBSDKShareButton alloc] init];
    button.shareContent = content;

    button.frame = CGRectMake(20, 20, 40, 40);
    [self addSubview:button];

}


#pragma mark - FBSDKSharingDelegate

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    NSLog(@"completed share:%@", results);
    [self removeFromSuperview];
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    NSLog(@"sharing error:%@", error);
    NSString *message = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?:
    @"There was a problem sharing, please try again later.";
    NSString *title = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops!";
    
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer
{
    NSLog(@"share cancelled");
}

@end
