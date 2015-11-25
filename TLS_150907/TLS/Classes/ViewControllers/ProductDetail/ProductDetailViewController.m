//
//  ProductDetailViewController.m
//  TLS
//
//  Created by 屠淋 on 15/8/23.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ShareView.h"
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import "ProductNameTableViewCell.h"
#import "QuickOverTableViewCell.h"
#import "DetailTableViewCell.h"
#import "MyCartViewController.h"
#import "ShopCartView.h"

@interface ProductDetailViewController ()<UITableViewDataSource,UITableViewDelegate,SGFocusImageFrameDelegate>

@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ShareView *shareView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *footViewConstraint;
@property (nonatomic, strong) SGFocusImageFrame *viewImage;
@property (nonatomic, strong) NSDictionary *dicData;
@end

@implementation ProductDetailViewController

- (ShareView*)shareView{
    
    if (!_shareView) {
        _shareView = [[ShareView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _shareView;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.viewImage.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.numLabel.layer.cornerRadius = 9;
    self.numLabel.layer.masksToBounds = YES;
    NSString *num = [JXUserDefault objectValueForKey:cartList];
    
    self.numLabel.text = num;
    
    if ([self.numLabel.text length] == 0 ) {
        self.numLabel.hidden = YES;
    }else{
        self.numLabel.hidden = NO;
        self.footViewConstraint.constant = 50;

    }

    self.backgroundView.hidden = ![[HomeShareInfo sharedHomeInfoModel] isThroughAudit];
    self.footViewConstraint.constant = ![[HomeShareInfo sharedHomeInfoModel] isThroughAudit]
    ? 0 : 50;

    self.title = @"Product Details";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"share" highlightIcon:@"" target:self action:@selector(shareTo:)];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];

    [self requestProductDetail];
}



#pragma mark - scrollView

- (void)loadPicturewithView:(UIView*)superView andDic:(NSArray*)arrayData{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *arr = [NSMutableArray array];
    
    for (int i = 0 ; i < arrayData.count; i ++) {
        NSDictionary *dataDic = arrayData[i];
        NSDictionary *dicSub = @{@"Title":@"",@"PicUrl":dataDic[@"url"]};
        [arr addObject:dicSub];
    }
    
    [dic setObject:arr forKey:@"ResponseData"];
    
    NSArray *reArray = [ShufflingInfo paraseShufflingInfoWithData:[dic objectForKey:@"ResponseData"]];
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:[reArray count]];
    
    for (int i = 0; i < [reArray count]; i++) {
        SGFocusImageItem *item = [[SGFocusImageItem alloc] initWithShufflingInfo:[reArray objectAtIndex:i]];
        [tempArray addObject:item];
    }
    NSInteger length = [tempArray count];
    NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:length+2];
    //添加最后一张
    if (length > 1) {
        SGFocusImageItem *lastItem = [tempArray objectAtIndex:length - 1];
        [itemArray addObject:lastItem];
    }
    for (int i = 0; i < length; i++)
    {
        SGFocusImageItem *item = [tempArray objectAtIndex:i];
        [itemArray addObject:item];
    }
    //添加第一张
    if (length >1)
    {
        SGFocusImageItem *item = [tempArray objectAtIndex:0];
        [itemArray addObject:item];
    }
    
    SGFocusImageFrame *view = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(60, 20, SCREEN_WIDTH - 120, 180) delegate:self imageItems:itemArray];
    view.myPageIndicatorTintColor = [UIColor lightGrayColor];
    view.myCurrentPageIndicatorTintColor = ThemeColor;
    [superView addSubview:view];
    self.viewImage = view;
}


#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndetifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier];
    switch (indexPath.row) {
        case 0://Image
        {
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor whiteColor];
            cell.selectedBackgroundView = view;
            [self loadPicturewithView:cell.contentView andDic:self.dicData[@"images"]];
            
        }
            break;
        case 1://productName
        {
            ProductNameTableViewCell *cell = NIB_Load(@"ProductNameTableViewCell");
            cell.nameLabel.text = self.dicData[@"productName"];
            NSString *moneyNum = [self numberFormatterWithNumber:self.dicData[@"price"]];

            if ([[HomeShareInfo sharedHomeInfoModel] isThroughAudit]) {
                cell.moneyLabel.text = [NSString stringWithFormat:@"$ %@",moneyNum];
                cell.moneyLabel.font = [UIFont boldSystemFontOfSize:15];
            }else{
                cell.moneyLabel.text = @"sign in for price";
                cell.moneyLabel.textColor = [UIColor whiteColor];
                cell.moneyLabel.backgroundColor = [UIColor lightGrayColor];
                cell.moneyLabel.font = [UIFont systemFontOfSize:15];

            }
            cell.modelLabel.text = self.dicData[@"model"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 2://availability
        {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            cell.textLabel.text = @"Availability (May Vary)";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            if ([self.dicData[@"availability"] isEqualToString:@"1"]) {
                cell.detailTextLabel.text = @"In stcok";

            }else{
                cell.detailTextLabel.text = @"Out stcok";

            }
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.textColor = UIColorFromRGB(0x65c607);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }
            break;
        case 3://QUICK OVERVIEW
        {
            QuickOverTableViewCell *cell = NIB_Load(@"QuickOverTableViewCell");
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.webView loadHTMLString:self.dicData[@"shortdescription"] baseURL:nil];
            return cell;
        }
            break;
        case 4://details specification downloads
        {
            DetailTableViewCell *cell = NIB_Load(@"DetailTableViewCell");
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.dataArray = @[mAvailableString(self.dicData[@"description"]),mAvailableString(self.dicData[@"specifications"]),@""];
            return cell;
        }
            break;
            
        default:
            break;
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 ) {
        return 220;
    }else if (indexPath.row == 1){
        return 80;
    }else if (indexPath.row == 2){
        return 35;
    }else if (indexPath.row == 3){
        return 140;
    }else if (indexPath.row == 4){
        return 220;
    }
    return 0;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shareTo:(UIButton*)btn{
    
    [self.navigationController.view addSubview:self.shareView];

    [self.shareView showShareView];

}


#pragma mark - SGFocusImageFrameDelegate

- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item{
    
    
}


- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame currentItem:(int)index{
    
    
    
}

#pragma mark - Request

- (void)requestProductDetail{
    
    [self.view showProgressHUDWithInfo:alert_Loading];
    //mobile.ltsecurityinc.com/api3/products/info?id=168
    [Networking GetAFNRequestWithParameters:@{@"id":mAvailableString(self.product_id)} andHttpType:@"products" action:@"info" withSuccessBlock:^(id dicResult) {
        NSLog(@"request success:%@",dicResult);
        [self.view hiddenProgressHUD];
        self.dicData = [[dicResult objectForKey:@"data"] firstObject];
        [self.tableView reloadData];
    } withErrorBlock:^(id dicResult, NSString *error) {
        [self.view hiddenProgressHUD];
        NSLog(@"请求失败: %@",dicResult);


    }];

}

- (NSString *)numberFormatterWithNumber:(NSString *)number
{
    CGFloat num = [number doubleValue];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [formatter stringFromNumber:[NSNumber numberWithDouble:num]];
    
    return formattedNumberString;
}

#pragma mark - addToCart

- (IBAction)addToCart:(UIButton*)btn{
    [self.view showProgressHUDWithInfo:alert_Loading];
    NSDictionary *dic = @{@"productid":mAvailableString(self.product_id),
                          @"customerid":mAvailableString([HomeShareInfo sharedHomeInfoModel].userInfo.customerid)};
    
    [Networking GetAFNRequestWithParameters:dic andHttpType:@"carts" action:@"addItem" withSuccessBlock:^(id dicResult) {
        NSLog(@"请求成功:%@",dicResult);
        [self requetCartNum];
        
        
    } withErrorBlock:^(id dicResult, NSString *error) {
        
        NSLog(@"请求失败:%@",dicResult);
        [self.view alertViewShowWithMessage:dicResult[@"message"] View:self.navigationController.view];
        [self.view hiddenProgressHUD];

    }];
    
    
}


- (void)requetCartNum{
    
    NSDictionary *dic = @{@"customerid":mAvailableString([HomeShareInfo sharedHomeInfoModel].userInfo.customerid)};
    
    [Networking GetAFNRequestWithParameters:dic andHttpType:@"carts" action:@"getItemsCount" withSuccessBlock:^(id dicResult) {
        NSLog(@"请求成功:%@",dicResult);
        
        NSString *data = (dicResult[@"data"] == [NSNull null] ? @"" : dicResult[@"data"]);
        
        [JXUserDefault setObjectValue:mAvailableString(data) forKey:cartList];
        
        self.numLabel.text = [NSString stringWithFormat:@"%@",mAvailableString(data)];
        
        if ([self.numLabel.text length] == 0 ) {
            self.numLabel.hidden = YES;
        }else{
            self.numLabel.hidden = NO;
        }
        [self.view hiddenProgressHUD];
    } withErrorBlock:^(id dicResult, NSString *error) {
        NSLog(@"请求失败:%@",dicResult);
        [self.view hiddenProgressHUD];

    }];
    
    
}

- (IBAction)cartButton:(UIButton *)sender {
    
    MyCartViewController *cartVC = [[MyCartViewController alloc]init];
    
    [self.navigationController pushViewController:cartVC animated:YES];
    
}


@end
