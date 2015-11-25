//
//  ProductListViewController.m
//  TLS
//
//  Created by 屠淋 on 15/9/15.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "ProductListViewController.h"
#import "SearchResultTableViewCell.h"
#import "ProductDetailViewController.h"

@interface ProductListViewController ()
{
    NSString *cellIdentifier;
   
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Promotions";
    
    cellIdentifier = @"SearchResultTableViewCell";
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchResultTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self setShopRightItem];    

    [self requetPromotions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.promotionArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell promotionDic:self.promotionArray[indexPath.row]];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.promotionArray[indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProductDetailViewController *detailVC = [[ProductDetailViewController alloc]init];
    detailVC.product_id = dic[@"id"];
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (void)requetPromotions{
    
//    mobile.ltsecurityinc.com/api2/promotions
    [self.view showProgressHUDWithInfo:alert_Loading];
    [Networking getRequestWithHTTPName:@"promotions" withSuccessBlock:^(id dicResult) {
        NSLog(@"请求成功:%@",dicResult);
        [self.view hiddenProgressHUD];
        self.promotionArray = dicResult[@"data"];
        [self.tableView reloadData];
        
    } withErrorBlock:^(id dicResult, NSString *error) {
        NSLog(@"请求失败:%@",dicResult);
        [self.view alertViewShowWithMessage:error View:self.navigationController.view];
        [self.view hiddenProgressHUD];

    }];

}


@end
