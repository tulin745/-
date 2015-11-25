//
//  OpenFileViewController.m
//  CRM
//
//  Created by chunjia wei on 15-3-2.
//  Copyright (c) 2015年 wei. All rights reserved.
//

#import "OpenFileViewController.h"

@interface OpenFileViewController ()<UIAlertViewDelegate>


@end

@implementation OpenFileViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.previewController = nil;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _previewController = [[QLPreviewController alloc] init] ;
    _previewController.dataSource = self;
    _previewController.delegate = self;
    _previewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height);
    _previewController.view.backgroundColor = [UIColor whiteColor];
    _previewController.currentPreviewItemIndex = 0;
    [self.view addSubview:_previewController.view];
    
    if ([self isExistsFile:self.filePath]) {
        
        [_previewController reloadData];
        
    }else{
    
        if ([self checkNetwork]) {
            
            [self downloadFileWithURL:self.downloadPath andFileName:self.fileName];
            
        }else{
            
        }
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//检测当前网络
- (BOOL)checkNetwork
{
    BOOL reachable = [[ECTNetworkSpy sharedNetworkSpy] checkNetworkReachable];
    BOOL viaWifi = [[ECTNetworkSpy sharedNetworkSpy] checkWiFiReachable];
    NSString* title = @"网络在开小差，检查后再试吧";
    
    if (!reachable) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Advice" message:@"The Internet connection appears to be offline,please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    else if (viaWifi) {
        title = @"当前wifi已连接";
        return YES;
    }
    else {
        title = @"当前2g/3g已连接";
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Advice" message:@"The file size may be  large\nWhether or not to continue " delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"continue", nil];
        [alertView show];
        return NO;
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        [self downloadFileWithURL:self.downloadPath andFileName:self.fileName];

    }

}

#pragma mark - QLPreviewItem
- (id <QLPreviewItem>) previewController: (QLPreviewController *) controller previewItemAtIndex: (NSInteger) index
{
    NSURL *fileURL = [NSURL fileURLWithPath:self.filePath];
    return fileURL;
    
}
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1;
}

#pragma mark - 下载文件

- (void)downloadFileWithURL:(NSString*)url andFileName:(NSString*)fileName{
    
    [self.view showProgressHUDWithInfo:alert_Loading];
    [Networking downFileWithUrl:url andFileName:fileName andBlock:^(BOOL isSuccess, NSError *error) {
        
        [self.view hiddenProgressHUD];
        
        if (isSuccess) {
            NSLog(@"下载完成");
            if (self.previewController) {
                [self.previewController reloadData];

            }
            
        }else{
            NSLog(@"下载失败");
            [self.view alertViewShowWithMessage:error.userInfo[@""] View:self.navigationController.view];
        }
    }];
    
}

- (BOOL)isExistsFile:(NSString*)filePath{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath]) {
        return YES;
    }
    return NO;
}

@end