//
//  AccountViewController.m
//  TLS
//
//  Created by 屠淋 on 15/8/8.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "AccountViewController.h"
#import "InformationViewController.h"
#import "ModifyPasswordViewController.h"
#import "AccountTableViewCell.h"
#import "MyOrdersViewController.h"
#import "MyCartViewController.h"
#import "MyMessagesViewController.h"
#import "SetingViewController.h"
#import "LoginViewController.h"
#import "HomeViewController.h"

@interface AccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableview;
@property(nonatomic, strong) NSMutableArray *dataAry;

@end

@implementation AccountViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self loadData];
    self.navigationItem.title = @"My Account";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"xiaoxi" Size:CGSizeMake(22, 22) target:self action:@selector(openMessage)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"shezhi" Size:CGSizeMake(22, 22) target:self action:@selector(shezhi)];
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableview setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.view addSubview:_tableview];
    
}



- (void)openMessage{
    MyMessagesViewController *messageVC = [[MyMessagesViewController alloc]init];
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (void)shezhi{
    SetingViewController *settingVC = [[SetingViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadData{
    _dataAry = [NSMutableArray array];
    NSMutableDictionary *information = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Company Information",@"title", nil];
    NSArray *ary1 = @[information];
    
    NSMutableDictionary *cart = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"My Cart",@"title",@"shopping-mart",@"titleImage", nil];
    NSMutableDictionary *orders = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"My Orders",@"title",@"order",@"titleImage", nil];
    NSArray *ary2 = @[cart,orders];
    
    NSMutableDictionary *service = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Service",@"title",@"400-888-888",@"valueStr", nil];
    NSMutableDictionary *about =[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"About",@"title", nil];
    NSString *build = [NSString stringWithFormat:@"V%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    NSMutableDictionary *version = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Version:",@"title",build,@"valueStr", nil];
    NSArray *ary3 = @[about,service,version];
    
    [_dataAry addObject:ary1];
    [_dataAry addObject:ary2];
    [_dataAry addObject:ary3];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_dataAry count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataAry[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *cellAry = [[NSBundle mainBundle]loadNibNamed:@"AccountTableViewCell" owner:self options:nil];
    AccountTableViewCell *cell;
    NSArray *ary = _dataAry[indexPath.section];
    NSDictionary *dic = ary[indexPath.row];
    if (!cell) {
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                cell = cellAry[0];
                cell.titleStr.text = [dic objectForKey:@"title"];
            }else{
                cell = cellAry[2];
                cell.titleFirstStr.text = [dic objectForKey:@"title"];
                cell.valueStr.text = [dic objectForKey:@"valueStr"];
            }
        }else if(indexPath.section == 1){
            cell = cellAry[indexPath.section];
            NSLog(@"dic:%@",dic);
            NSString *imageName = [dic objectForKey:@"titleImage"];
            cell.titleImage.image = [UIImage imageNamed:imageName];
            cell.titleCenterStr.text = [dic objectForKey:@"title"];
            
        }else if (indexPath.section == 0){
            cell = cellAry[indexPath.section];
            cell.titleStr.text = [dic objectForKey:@"title"];
        }
    }
   
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    NSArray *ary = _dataAry[indexPath.section];

    NSDictionary *dic = ary[indexPath.row];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            InformationViewController *informationVC = [[InformationViewController alloc]init];
            informationVC.informationType = @"Company";
            [self.navigationController pushViewController:informationVC animated:YES];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            MyCartViewController *cartVC = [[MyCartViewController alloc]init];
            [self.navigationController pushViewController:cartVC animated:YES];
        }else if (indexPath.row == 1){
            MyOrdersViewController *ordersVC = [[MyOrdersViewController alloc]init];
            [self.navigationController pushViewController:ordersVC animated:YES];
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            
        }else if (indexPath.row == 1){
            
            UIWebView *web = [[UIWebView alloc]init];
            
            NSString * str=[[NSString alloc] initWithFormat:@"tel:%@",mAvailableString(dic[@"valueStr"])];
            
            [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            
        }else if (indexPath.row == 2){
            
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}



@end
