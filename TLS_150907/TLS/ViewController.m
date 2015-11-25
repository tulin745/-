//
//  ViewController.m
//  TLS
//
//  Created by 屠淋 on 15/7/25.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "ViewController.h"

#import <FBSDKShareKit/FBSDKShareKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBSDKShareLinkContent * content  = [[FBSDKShareLinkContent alloc]init];
    
    content.contentURL = [NSURL URLWithString:@"https://developers.facebook.com"];
    
    
    FBSDKShareButton *button = [[FBSDKShareButton alloc] init];
    button.shareContent = content;
    button.frame = CGRectMake(100 , 100, 200, 100);
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
