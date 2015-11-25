//
//  CatelogNewViewController.m
//  TLS
//
//  Created by 屠淋 on 15/11/20.
//  Copyright © 2015年 tulin. All rights reserved.
//

#import "CatelogNewViewController.h"
#import <QuickLook/QuickLook.h>
#import "NewMenuViewController.h"

#import "SearchResultViewController.h"

@interface CatelogNewViewController ()<QLPreviewControllerDataSource,QLPreviewControllerDelegate,NewMenuViewControllerDelegate>

@property (nonatomic,strong) QLPreviewController *previewController;

@property (nonatomic, strong) NSDictionary *catelogDic;

@property (nonatomic, copy) NSString *filePath;

@property (nonatomic, strong) NewMenuViewController *menuViewController;


@end

@implementation CatelogNewViewController

- (NewMenuViewController*)menuViewController{
    
    if (!_menuViewController ) {
        _menuViewController = [[NewMenuViewController alloc]init];
        _menuViewController.view.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _menuViewController.delegate = self;
        
        
        NSArray *windows = [UIApplication sharedApplication].windows;
        for (UIWindow *WD in windows) {
            if (WD != nil) {
                
                [WD addSubview:self.menuViewController.view];
            }
        }
    }
    return _menuViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.filePath = @"";
    
    self.navigationItem.title = @"Catalog";

    [self setMenuLeftItem];
    [self setShopRightItem];
    
    _previewController = [[QLPreviewController alloc] init] ;
    _previewController.dataSource = self;
    _previewController.delegate = self;
    _previewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height);
    _previewController.view.backgroundColor = [UIColor whiteColor];
    _previewController.currentPreviewItemIndex = 0;
    [self.view addSubview:_previewController.view];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self getCatelogFile];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//检测是否有文件
- (BOOL)isExistsFile:(NSString*)filePath{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath]) {
        return YES;
    }
    return NO;
}

- (void)getCatelogFile{
    
    [Networking getRequestWithHTTPName:@"catelog" withSuccessBlock:^(id dicResult) {
        NSLog(@"request success:%@",dicResult);

        //        NSDictionary *dic = [JXUserDefault objectValueForKey:@"Catelog_PDF"];
        self.catelogDic = dicResult;
        [self DownloadFileWithDic:dicResult];
        
        [JXUserDefault setObjectValue:dicResult forKey:@"Catelog_PDF"];
        
    } withErrorBlock:^(id dicResult, NSString *error) {
        NSLog(@"请求失败: %@",dicResult);
        [self.view alertViewShowWithMessage:dicResult[@"message"] View:self.navigationController.view];

        
    }];
}

- (void)DownloadFileWithDic:(NSDictionary*)dic{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    
    if ([[HomeShareInfo sharedHomeInfoModel] isThroughAudit]) {
        
        NSString *filePath = [docDir stringByAppendingPathComponent:@"Verson2-PDF.pdf"];
        
        NSString *version2 = dic[@"version2"];
        NSString *localVersion2 = [JXUserDefault objectValueForKey:@"Catelog_PDF"][@"version2"];
        
        if ([version2 isEqualToString:localVersion2] && [self isExistsFile:filePath]) {
            
            [self getFilePath:@"Verson2-PDF.pdf"];
            
            [self.previewController reloadData];
            
        }else{
            
            self.filePath = @"";
            [self.previewController reloadData];
            [self downloadFileWithURL:self.catelogDic[@"url2"] andFileName:@"Verson2-PDF.pdf"];

        }
        
    }else{
        
        NSString *filePath = [docDir stringByAppendingPathComponent:@"Verson1-PDF.pdf"];

        
        NSString *version2 = dic[@"version1"];
        NSString *localVersion2 = [JXUserDefault objectValueForKey:@"Catelog_PDF"][@"version1"];
        
        if ([version2 isEqualToString:localVersion2] && [self isExistsFile:filePath]) {
            
            [self getFilePath:@"Verson1-PDF.pdf"];
            
            [self.previewController reloadData];
            
        }else{
            self.filePath = @"";
            [self.previewController reloadData];
            [self downloadFileWithURL:self.catelogDic[@"url1"] andFileName:@"Verson1-PDF.pdf"];
            
        }
        
        
    }
    
}

#pragma mark - 下载文件

- (void)downloadFileWithURL:(NSString*)url andFileName:(NSString*)fileName{

    url = mAvailableString(url);
    [Networking downFileWithUrl:url andFileName:fileName andBlock:^(BOOL isSuccess, NSError *error) {
        
        [self.view hiddenProgressHUD];
        
        if (isSuccess) {
            NSLog(@"下载完成");
            [self getFilePath:fileName];
            
        }else{
            NSLog(@"下载失败");
            [self.view alertViewShowWithMessage:@"Download failed" View:self.navigationController.view];
        }
    }];
    
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

- (void)getFilePath:(NSString *)fileName{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docDir = [paths objectAtIndex:0];
    
   self.filePath = [docDir stringByAppendingPathComponent:fileName];

    [self.previewController reloadData];
}

#pragma mark - MenuViewControllerDelegate

- (void)menuVC:(NewMenuViewController *)vc andInfo:(CategorieInfo *)info{
    
    [vc hidden];
    
    SearchResultViewController *searchVC = [[SearchResultViewController alloc]initWithNibName:@"SearchResultViewController" bundle:nil];
    searchVC.title = info.name;
    searchVC.ID = info.entity_id;
    
    [self.navigationController pushViewController:searchVC animated:YES];
    
}

#pragma mark - 展开 / 隐藏  菜单

- (void)showMenu{
    
    [self.menuViewController show];
    [self.view endEditing:YES];
}




@end
