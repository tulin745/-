//
//  BaseViewController.m
//  ECTECTIphone
//
//  Created by mac on 15/5/19.
//
//

#import "BaseViewController.h"

#import "MyCartViewController.h"
#import "CustomNavViewController.h"
#import "SearchResultViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>




@end

@implementation BaseViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarController.tabBar.translucent = NO;
        self.navigationController.navigationBar.translucent = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [UIView setAnimationsEnabled:YES];//解决pop和push 可能消失的状况
    self.navigationController.navigationBarHidden = NO;
    [self reloadShopCartNum];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    if (IsIos7Later) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        self.edgesForExtendedLayout = UIRectEdgeNone;

    }

    [self setLelftNavigationItem:NO];
        
//    [self addChildViewController:self.menuViewController];
    

}



- (void)logoutAction
{
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)setLelftNavigationItem:(BOOL)hidden
{
    if (!hidden) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"back" target:self action:@selector(backPage)];
    }else{
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
    }
}

- (void)setMenuLeftItem
{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"cate" target:self action:@selector(showMenu)];
    
}

- (void)setShopRightItem
{
    if ([[HomeShareInfo sharedHomeInfoModel] isThroughAudit]) {
        
        ShopCartView *shopV = [[ShopCartView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
        [shopV.button addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
        NSString * cartNumStr = [JXUserDefault objectValueForKey:cartList];
        shopV.cartNum = cartNumStr;
        self.cartView = shopV;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:shopV];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backPage
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)dissPage
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

-(void)rightBtnAction
{
    ;
}

- (void)popToRootVC{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

#pragma mark - 展开 / 隐藏  菜单

- (void)showMenu{
    
  
}


#pragma mark -rightButton

- (void)rightButton:(UIButton*)button{
    
    MyCartViewController *cartVC = [[MyCartViewController alloc]initWithNibName:@"MyCartViewController" bundle:nil];
    [self.navigationController pushViewController:cartVC animated:YES];
}

#pragma mark - 添加/删除购物车的角标

- (void)addItemsToCart{
    
    NSString * cartNumStr = [JXUserDefault objectValueForKey:cartList];
    NSInteger carNum = [cartNumStr integerValue];
    carNum ++;
    cartNumStr = [NSString stringWithFormat:@"%ld",(long)carNum];
    [JXUserDefault setObjectValue:cartNumStr forKey:cartList];

}

- (void)reloadShopCartNum{
    
    NSString * cartNumStr = [JXUserDefault objectValueForKey:cartList];
    self.cartView.cartNum = cartNumStr;
    [self.cartView setNeedsLayout];
}



@end