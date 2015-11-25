//
//  MyCartViewController.m
//  TLS
//
//  Created by 屠淋 on 15/8/22.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "MyCartViewController.h"
#import "MyCartTableViewCell.h"


@interface MyCartViewController ()<UITableViewDataSource,UITableViewDelegate,MyCartTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UIButton *selected;
@property (weak, nonatomic) IBOutlet UILabel *labelMoney;

@property (weak, nonatomic) IBOutlet UIView *footView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *dicData;

@property (nonatomic, strong) NSMutableDictionary *dicSeleted;

@end

@implementation MyCartViewController

- (NSMutableDictionary*)dicSeleted{
    
    if (!_dicSeleted) {
        _dicSeleted = [NSMutableDictionary dictionary];
    }
    return _dicSeleted;
}


- (NSMutableDictionary*)dicData{
    
    if (!_dicData) {
        _dicData = [NSMutableDictionary dictionary];
    }

    return _dicData;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.tableView.editing = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Cart";

    [self cartListRequest];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"clear" target:self action:@selector(clearData)];
    self.selected.titleEdgeInsets = UIEdgeInsetsMake(0, 7, 0, 0);
    self.labelMoney.adjustsFontSizeToFitWidth = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dicData[@"items"];
    return array.count;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = self.dicData[@"items"];

    NSDictionary *dic = array[indexPath.row];
    static NSString *cellIdentifier = @"MyCartTableViewCell";
    
    MyCartTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = NIB_Load(@"MyCartTableViewCell");
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.indexPath = indexPath;
    [cell getContentWithDic:dic];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;

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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return YES;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        [self removeCartItemsWithIndexpaths:@[indexPath]];
    }
    
}

//删除购物车
- (void)removeCartItemsWithIndexpaths:(NSArray*)indexPaths{
    
    NSMutableArray *array = [self.dicData[@"items"] mutableCopy];
    
    NSMutableArray *arrayItems = [NSMutableArray array];
    for (int i = 0;i < array.count;i++) {
        NSDictionary *dicData = array[i];
        for (NSIndexPath *indexPath in indexPaths) {
            if (i == indexPath.row) {
                [arrayItems addObject:dicData[@"item_id"]];
            }
        }
    }
    
    NSError *praseError = nil;
    NSData * data = [NSJSONSerialization dataWithJSONObject:arrayItems options:NSJSONWritingPrettyPrinted error:&praseError];
    NSString * items = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = @{@"customerid":mAvailableString([HomeShareInfo sharedHomeInfoModel].userInfo.customerid),
                          @"items":items};
    
    [Networking GetAFNRequestWithParameters:dic andHttpType:@"carts" action:@"removeItem" withSuccessBlock:^(id dicResult) {
        NSLog(@"请求成功:%@",dicResult);
        
        for (NSIndexPath *indexPath in indexPaths) {
            
            NSDictionary *subDic = array[indexPath.row];
            [array removeObject:subDic];
            [self.dicData setObject:array forKey:@"items"];
            
        }
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        
        NSString *numStr = [JXUserDefault objectValueForKey:cartList];
        NSInteger num = [numStr integerValue];
        num--;
        [JXUserDefault setObjectValue:[NSString stringWithFormat:@"%ld",(long)num] forKey:cartList];
     
        [self.selected setTitle:@"Selected:0" forState:UIControlStateNormal];
        self.selected.selected = NO;
        self.labelMoney.text = @"$0.00";
        
        [self.tableView reloadData];
        
    } withErrorBlock:^(id dicResult, NSString *error) {
        
        NSLog(@"请求失败:%@",dicResult);
        [self.view alertViewShowWithMessage:dicResult[@"message"] View:self.navigationController.view];
    }];
    

}


#pragma mark - MyCartTableViewCellDelegate

- (void)updateItemWithStr:(NSString *)itemQty andIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *array = [self.dicData[@"items"] mutableCopy];
    
    NSDictionary *dicData = array[indexPath.row];
    
    NSDictionary *dic = @{@"customerid":mAvailableString([HomeShareInfo sharedHomeInfoModel].userInfo.customerid),
                          @"itemid":dicData[@"item_id"],
                          @"qty":itemQty};
    
    [Networking GetAFNRequestWithParameters:dic andHttpType:@"carts" action:@"updateItem" withSuccessBlock:^(id dicResult) {
        NSLog(@"请求成功:%@",dicResult);
        
        
    } withErrorBlock:^(id dicResult, NSString *error) {
        
        NSLog(@"请求失败:%@",dicResult);
        [self.view alertViewShowWithMessage:dicResult[@"message"] View:self.navigationController.view];
    }];

}


- (void)selectedGOODs:(UIButton *)button andIndexPath:(NSIndexPath *)indexPath{

    NSMutableArray *array = [self.dicData[@"items"] mutableCopy];
    NSDictionary *dicData = array[indexPath.row];
    
//    计算选中个数
    if (button.selected ) {
        [self.dicSeleted setObject:dicData forKey:indexPath];
    }else{
        [self.dicSeleted removeObjectForKey:indexPath];
    }
    [self.selected setTitle:[NSString stringWithFormat:@"Selected:%ld",(long)self.dicSeleted.count] forState:UIControlStateNormal];
    
    // 计算价格
    CGFloat sum = 0;
    NSArray *keys = [self.dicSeleted allKeys];
    for (NSString *key in keys) {
        NSDictionary *dic = self.dicSeleted[key];
        sum = [dic[@"product_price"] floatValue] * [dic[@"product_qty"] integerValue] + sum;
    }
    NSString *num  = [self numberFormatterWithNumber:[NSString stringWithFormat:@"%.2f",sum]];
    self.labelMoney.text = [NSString stringWithFormat:@"$ %@",num];
    
    self.selected.selected = (self.dicSeleted.count != 0);
    
}

- (void)clearData{
    
    NSDictionary *dic = @{@"customerid":mAvailableString([HomeShareInfo sharedHomeInfoModel].userInfo.customerid)};
    
    [Networking GetAFNRequestWithParameters:dic andHttpType:@"carts" action:@"removeAll" withSuccessBlock:^(id dicResult) {
        NSLog(@"请求成功:%@",dicResult);
        [self.dicData removeAllObjects];
        [self.tableView reloadData];
        [JXUserDefault setObjectValue:@"0" forKey:cartList];

    } withErrorBlock:^(id dicResult, NSString *error) {
        
        NSLog(@"请求失败:%@",dicResult);
        [self.view alertViewShowWithMessage:dicResult[@"message"] View:self.navigationController.view];
    }];

}


- (void)cartListRequest{
    
    NSDictionary *dic = @{@"customerid":mAvailableString([HomeShareInfo sharedHomeInfoModel].userInfo.customerid)};
    [self.view showProgressHUDWithInfo:alert_Loading];
    [Networking GetAFNRequestWithParameters:dic andHttpType:@"carts" action:@"getItems" withSuccessBlock:^(id dicResult) {
        NSLog(@"请求成功:%@",dicResult);
        [self.view hiddenProgressHUD];
        self.dicData = [[dicResult[@"data"] firstObject] mutableCopy];
        
        [self.tableView reloadData];
    } withErrorBlock:^(id dicResult, NSString *error) {
        [self.view hiddenProgressHUD];
        NSLog(@"请求失败:%@",dicResult);
        [self.view alertViewShowWithMessage:dicResult[@"message"] View:self.navigationController.view];
    }];
    
}
- (IBAction)creatOrder:(UIButton *)sender {
    
    //http://mobile.ltsecurityinc.com/api2/carts/createorder?params={"customerid":10616,"productlist":[{"product_id":641,"product_qty":1},{"product_id":326,"product_qty":1}

    //取出选中的 商品
    NSArray *selectedKey = [self.dicSeleted allKeys];
//    NSMutableArray *productlistArr = [NSMutableArray array];
    
    NSMutableArray *product_ids = [NSMutableArray array];
    NSMutableArray *product_qtys = [NSMutableArray array];
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    for (NSString *key in selectedKey) {
        NSDictionary *dic = self.dicSeleted[key];
//        NSDictionary *dicData = @{@"product_id":dic[@"product_id"],@"product_qty":dic[@"product_qty"]};
        [product_ids addObject:dic[@"product_id"]];
        [product_qtys addObject:dic[@"product_qty"]];
        [indexPaths addObject:key];
    }
    
    NSString *productIdStr = [self jsonChange:product_ids];
    NSString *productQtyStr = [self jsonChange:product_qtys];

    NSDictionary *dicParams = @{@"customerid":mAvailableString([HomeShareInfo sharedHomeInfoModel].userInfo.customerid),@"product_id":productIdStr,@"product_qty":productQtyStr};
    
    [self.view showProgressHUDWithInfo:alert_Loading];
    [Networking GetAFNRequestWithParameters:dicParams andHttpType:@"carts" action:@"createorder2" withSuccessBlock:^(id dicResult) {
        NSLog(@"请求成功:%@",dicResult);
        [self.view hiddenProgressHUD];
       
        [self removeCartItemsWithIndexpaths:indexPaths];
        
    } withErrorBlock:^(id dicResult, NSString *error) {
        [self.view hiddenProgressHUD];
        NSLog(@"请求失败:%@",dicResult);
        [self.view alertViewShowWithMessage:dicResult[@"message"] View:self.navigationController.view];
    }];
    
}


- (NSString *)numberFormatterWithNumber:(NSString *)number//
{
    CGFloat num = [number doubleValue];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [formatter stringFromNumber:[NSNumber numberWithDouble:num]];
    
    return formattedNumberString;
}

- (NSString*)jsonChange:(id)objct{
    
    NSError *praseError = nil;
    NSData * data = [NSJSONSerialization dataWithJSONObject:objct options:NSJSONWritingPrettyPrinted error:&praseError];
    NSString * paramStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return paramStr;
}

@end
