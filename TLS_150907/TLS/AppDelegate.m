//
//  AppDelegate.m
//  TLS
//
//  Created by 屠淋 on 15/7/25.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "AppDelegate.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import <FBSDKShareKit/FBSDKShareKit.h>

#import "WelcomeViewController.h"

#import "HomeViewController.h"
#import "CatelogNewViewController.h"
#import "SupportViewController.h"
#import "ContactViewController.h"
#import "AccountViewController.h"

#import "CustomNavViewController.h"
#import "LoginViewController.h"
#import "UserInfo.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@property (nonatomic, strong) UITabBarController *tabbar;
@property (nonatomic, strong) BaseClass *homeInfo;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FBSDKLikeControl class];
    [FBSDKLoginButton class];
    
    [self configRequest];
    [self loginStatus];
    
    [NSThread sleepForTimeInterval:1.5];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMainView) name:@"Login" object:nil];
    
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

- (void)loginStatus{
    
    
    if ([[HomeShareInfo sharedHomeInfoModel].userInfo.customerid length] != 0) {//是否登录 获取过entity_id
        
        [self loadMainView];
        
    }else{
        
        WelcomeViewController *welcomeVC = [[WelcomeViewController alloc]initWithNibName:@"WelcomeViewController" bundle:nil];
        
        CustomNavViewController *nav = [[CustomNavViewController alloc]initWithRootViewController:welcomeVC];
        
        welcomeVC.block = ^{
            
            [self loadMainView];
            
        };
        self.window.rootViewController = nav;
        
    }
    
    

}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)loadMainView
{
    
    HomeViewController *home = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    CustomNavViewController *homeNav = [[CustomNavViewController alloc] initWithRootViewController:home];
    
    homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:[[UIImage imageNamed:@"tab-home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab-home on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    CatelogNewViewController *catelogViewController = [[CatelogNewViewController alloc]initWithNibName:@"CatelogNewViewController" bundle:nil];
    CustomNavViewController *catelogNav = [[CustomNavViewController alloc] initWithRootViewController:catelogViewController];
    catelogNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Catalog" image:[[UIImage imageNamed:@"tab-down"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab-down-on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    SupportViewController*supportVC = [[SupportViewController alloc] initWithNibName:@"SupportViewController" bundle:nil];
    CustomNavViewController *supportNav = [[CustomNavViewController alloc] initWithRootViewController:supportVC];
    supportNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Support" image:[[UIImage imageNamed:@"tab-support"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab-support--on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    ContactViewController *ContactVC = [[ContactViewController alloc]initWithNibName:@"ContactViewController" bundle:nil];
    CustomNavViewController *ContactNav = [[CustomNavViewController alloc] initWithRootViewController:ContactVC];
    ContactNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Contact" image:[[UIImage imageNamed:@"tab call"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab-call-on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    AccountViewController *accountVC = [[AccountViewController alloc]initWithNibName:@"AccountViewController" bundle:nil];
    CustomNavViewController *accoutNav = [[CustomNavViewController alloc] initWithRootViewController:accountVC];
    accoutNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"My account" image:[[UIImage imageNamed:@"tab account"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab-account-on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    _tabbar = [[UITabBarController alloc] init];
    
    _tabbar.delegate = self;
    
    _tabbar.viewControllers = @[homeNav, catelogNav,supportNav,ContactNav,accoutNav];
    
    _tabbar.tabBar.barTintColor = UIColorFromRGB(0xf8f8f8);
    
    _tabbar.tabBar.translucent = NO;
    
    UIColor *titleHighlightedColor = UIColorFromRGB(0xDB0013);
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor blackColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    
    self.window.rootViewController = _tabbar;
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (viewController  == [tabBarController.viewControllers objectAtIndex:4]) {
        
        UserInfo *info = [HomeShareInfo sharedHomeInfoModel].userInfo;
        
        if ([info.customerid length] == 0) {//是否登录 获取过entity_id
            
            LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            loginVC.fromPlace = @"AppDelegate";
            [[self.tabbar.viewControllers objectAtIndex:self.tabbar.selectedIndex] pushViewController:loginVC animated:YES];
            return NO;
        }

    }
    return YES;

}


#pragma mark - Request

- (void)configRequest{//基本数据
    
    
    [Networking getRequestWithHTTPName:config_Request withSuccessBlock:^(NSDictionary *dicResult) {
        NSLog(@"request success:%@",dicResult);
        
        [self saveLocalWithDic:dicResult];//保存本地数据
        
        [HomeShareInfo sharedHomeInfoModel].HomeClass = [BaseClass modelObjectWithDictionary:dicResult];
        self.homeInfo = [HomeShareInfo sharedHomeInfoModel].HomeClass;
        
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"HomeInfoSccess" object:nil];
        
    } withErrorBlock:^(NSDictionary *dicResult, NSString *error) {
        NSLog(@"request failed:%@",dicResult);
        
        [self readData];
        
    }];
    
}

- (void)saveLocalWithDic:(NSDictionary*)dicResult{
    
    NSString *filePath = [self getHomeInfoFilePath];
    [dicResult writeToFile:filePath atomically:YES];
    
}

- (void)readData{//读取数据

    NSString *filePath = [self getHomeInfoFilePath];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    [HomeShareInfo sharedHomeInfoModel].HomeClass = [BaseClass modelObjectWithDictionary:dic];
    self.homeInfo = [HomeShareInfo sharedHomeInfoModel].HomeClass;
    
}

- (NSString*)getHomeInfoFilePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"Config.plist"];
    return filePath;
}

@end
