//
//  SetingViewController.m
//  TLS
//
//  Created by newtouch on 15/9/3.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "SetingViewController.h"
#import "SettingTableViewCell.h"
#import "InformationViewController.h"
#import "ModifyPasswordViewController.h"
#import "WelcomeViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface SetingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataAry;

@end

@implementation SetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadData];
    
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = @"Setting";
}

- (void)loadData{
    _dataAry = [NSMutableArray array];
    NSMutableDictionary *information = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Account Information",@"title", nil];
    NSArray *ary1 = @[information];
    
    NSMutableDictionary *modify = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Modify Password",@"title", nil];
    NSArray *ary2 = @[modify];
    
    NSMutableDictionary *exit = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Log Out",@"title", nil];
    NSArray *ary3 = @[exit];
    
    [_dataAry addObject:ary1];
    [_dataAry addObject:ary2];
    [_dataAry addObject:ary3];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataAry.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataAry[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *cellAry = [[NSBundle mainBundle]loadNibNamed:@"SettingTableViewCell" owner:nil options:nil];
    SettingTableViewCell *cell;
    NSArray *ary = _dataAry[indexPath.section];
    NSDictionary *dic = ary[indexPath.row];
    if (!cell) {
        if (indexPath.section == 2) {
            cell = cellAry[1];
            cell.titleCenterStr.text = [dic objectForKey:@"title"];
        }else{
            cell = cellAry[0];
            cell.titleStr.text = [dic objectForKey:@"title"];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        InformationViewController *informationVC = [[InformationViewController alloc]init];
        informationVC.informationType = @"Account";
        [self.navigationController pushViewController:informationVC animated:YES];
    }else if (indexPath.section == 1){
        ModifyPasswordViewController *modifyPasswordVC = [[ModifyPasswordViewController alloc]init];
        [self.navigationController pushViewController:modifyPasswordVC animated:YES];
    }else if (indexPath.section == 2){
//
        [self requestLoginOut];//退出登录
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)requestLoginOut{
    
    [self.view showProgressHUDWithInfo:@"Logout..."];
    
    NSDictionary *dic = @{@"customerid":mAvailableString([HomeShareInfo sharedHomeInfoModel].userInfo.customerid)};
    
    [Networking GetAFNRequestWithParameters:dic andHttpType:HttpType_customers action:@"logout" withSuccessBlock:^(id dicResult) {
        
        NSLog(@"请求成功:%@",dicResult);
        [self.view hiddenProgressHUD];
        //退出登录
//        NSMutableDictionary *dic = [[[JXUserDefault objectValueForKey:UserDefault_userInfo][@"data"] firstObject] mutableCopy];
//        NSArray *keys = [dic allKeys];
//        for (NSString *key in keys) {//清空所有数据
//            [dic setValue:@"" forKey:key];
//        }
        [JXUserDefault setObjectValue:nil forKey:UserDefault_userInfo];
        self.tabBarController.selectedIndex = 0;
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } withErrorBlock:^(id dicResult, NSString *error) {
        NSLog(@"请求失败:%@",dicResult);
        [self.view alertViewShowWithMessage:dicResult[@"message"] View:self.navigationController.view];
        [self.view hiddenProgressHUD];
    }];

}

@end
