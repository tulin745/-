//
//  SearchResultViewController.m
//  TLS
//
//  Created by 屠淋 on 15/8/23.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchResultTableViewCell.h"
#import "SearchHeadView.h"
#import "ProductDetailViewController.h"
#import "DropDownView.h"
#import "JSONKit.h"


@interface SearchResultViewController ()<UITableViewDataSource,UITableViewDelegate,SearchHeadViewDelegate,DropDownViewDelegate>
{
    NSString *cellIdentifier;
    NSString *pageIndex;
    BOOL _loadMore;
    NSString *_filter;
    NSString *_pattern;
    NSDictionary *_dicFiter;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (nonatomic, strong) NSMutableArray *arrayData;
@property (nonatomic, strong) NSArray *arrFiter;
@property (nonatomic, strong) DropDownView *dropDownView;

@end

@implementation SearchResultViewController

- (NSArray*)arrFiter{
    if (!_arrFiter) {
        _arrFiter = [NSArray arrayWithContentsOfFile:[self getFilterFilePath]];
    }
    return _arrFiter;
}

- (NSMutableArray*)arrayData{
    if (!_arrayData) {
        _arrayData = [NSMutableArray array];
    }
    return _arrayData;
}

- (DropDownView *)dropDownView{

    if (!_dropDownView) {
        _dropDownView = [[DropDownView alloc]initWithFrame:CGRectMake(0, - SCREEN_HEIGHT,  SCREEN_WIDTH, SCREEN_HEIGHT)];
        _dropDownView.categoryid = self.ID;
        _dropDownView.leftArray = self.arrFiter;
        _dropDownView.delegate = self;
        [_dropDownView reloadSubViews];
        [self.view insertSubview:_dropDownView belowSubview:self.headerView];

    }
    return _dropDownView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dicFiter = @{@"":@""};
    
    pageIndex = @"1";
    
    _filter = @"created_at";
    _pattern = @"desc";

    cellIdentifier = @"SearchResultTableViewCell";
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchResultTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self setShopRightItem];
    [self searchHeadView];
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRefeshing)];
    if (self.ID) {
        [self getFilter];
    }
    [self viewRefreshCurrentInterface];
    

}

- (void)tableViewHeadView{
    
    
    

}

- (void)searchHeadView{
    
    NSArray *arrayData = @[];
    if ([self.ID length] == 0) {//不是分类跳转过来
        
        arrayData = @[@"Newest",@"Price",@"Sales"];
        
    }else{
        
        arrayData = @[@"Newest",@"Price",@"Sales",@"Shop By"];
        
    }
    SearchHeadView *headView = [[SearchHeadView alloc]init];
    [headView  initWithArray:arrayData andFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    headView.backgroundColor = [UIColor whiteColor];
    headView.delegate = self;
    
    [self.headerView addSubview:headView];

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

    return self.arrayData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell IsNOApprovedWith:self.arrayData[indexPath.row]];
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 116;
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = self.arrayData[indexPath.row];
    ProductDetailViewController *detailVC = [[ProductDetailViewController alloc]init];
    detailVC.product_id = dic[@"product_id"];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - SearchHeadViewDelegate
- (void)headButtonAction:(UIButton *)button{
    
    switch (button.tag) {
        case 0:
        {
            _filter = @"created_at";
            _pattern = !button.selected ? @"desc" : @"asc";
            [self.arrayData removeAllObjects];
            [self.tableView reloadData];
            [self viewRefreshCurrentInterface];
        }
            break;
        case 1:
        {
            _filter = @"price";
            _pattern = !button.selected ? @"desc" : @"asc";
            [self.arrayData removeAllObjects];
            [self.tableView reloadData];
            [self viewRefreshCurrentInterface];

        }
            break;
        case 2:
        {
//            _filter = @"";
//            _pattern = !button.selected ? @"desc" : @"asc";
        }
            break;
        case 3:
        {
            if (button.selected) {
                [self.dropDownView show];
                self.tableView.userInteractionEnabled = NO;
                
            }else{
                [self.dropDownView hidden];
                self.tableView.userInteractionEnabled = YES;
                
            }
        }
            break;
        default:
            break;
    }


}

#pragma mark - userInteraction

/*
 *数据交互开启
 */
- (void)viewBeginDataInteraction{
    
    [self.tableView headerBeginRefreshing];
    
}

/*
 *数据交互结束
 */
- (void)viewEndDataInteraction{
    
    if (_loadMore) {
        [self.tableView footerEndRefreshing];
    } else {
        [self.tableView headerEndRefreshing];
    }
}

/*
 *刷新当前那界面
 */
- (void)viewRefreshCurrentInterface{
    
    [self viewBeginDataInteraction];
    
    
}

//下拉刷新回调此方法
- (void)headerRereshing
{
    _loadMore = NO;
    pageIndex = @"1";
    [self getSearchResult];
}

//上拉加载更多回调
- (void)footerRefeshing
{
    
    _loadMore = YES;
    int page = [pageIndex intValue];
    pageIndex = [NSString stringWithFormat:@"%d",++page];
    
    [self getSearchResult];
}


#pragma mark - 刷新

- (void)getFilter{

    if (self.arrFiter.count == 0) {
        [self.dropDownView showProgressHUD];
    }
    NSDictionary *dic = @{@"categoryid":mAvailableString(self.ID)};
    [Networking GetAFNRequestWithParameters:dic andHttpType:@"products" action:@"filter" withSuccessBlock:^(id dicResult) {
        NSLog(@"请求成功:%@",dicResult);
        [self.dropDownView hiddenProgress];
        self.arrFiter = dicResult[@"data"];
        [self.arrFiter writeToFile:[self getFilterFilePath] atomically:YES];
        self.dropDownView.leftArray = self.arrFiter;
        [self.dropDownView reloadSubViews];
    } withErrorBlock:^(id dicResult, NSString *error) {
        NSLog(@"请求失败:%@",dicResult);
        [self.dropDownView hiddenProgress];

    }];

}


- (void)getSearchResult{
    
    NSDictionary *dicOrderby = @{@"field":mAvailableString(_filter),@"pattern":mAvailableString(_pattern)};
    NSDictionary *dicFilters = @{@"categoryid":mAvailableString(self.ID),@"searchvalue":mAvailableString(self.searchValue)};
    NSDictionary *shopoptionsDic = _dicFiter;
    
    NSDictionary *dicJson = @{@"orderby":dicOrderby,
                              @"filters":dicFilters,
                              @"shopoptions":shopoptionsDic,
                              @"pageindex":mAvailableString(pageIndex),
                              @"pagesize":@"10"};
    
    
    // 字典转 json 字符串
    NSError *praseError = nil;
    NSData * data = [NSJSONSerialization dataWithJSONObject:dicJson options:NSJSONWritingPrettyPrinted error:&praseError];
    NSString * dicStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = @{@"params":mAvailableString(dicStr)};

    [Networking GetAFNRequestWithParameters:dic andHttpType:@"products" action:@"listadvanced" withSuccessBlock:^(id dicResult) {
        NSLog(@"请求成功:%@",dicResult);
        [self viewEndDataInteraction];
        
        if (_loadMore) {
            NSArray *arr = dicResult[@"data"];
            [self.arrayData addObjectsFromArray:arr];

        }else{
            
            self.arrayData = [dicResult[@"data"] mutableCopy];

        }
        
        [self.tableView reloadData];
        
    } withErrorBlock:^(id dicResult, NSString *error) {
        [self viewEndDataInteraction];
        NSLog(@"请求失败:%@",dicResult);
        [self.view alertViewShowWithMessage:dicResult[@"message"] View:self.navigationController.view];
    }];

}

- (NSString*)getFilterFilePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"FiterList.plist"];
    return filePath;
}

#pragma mark - DropDownViewDelegate

- (void)fiterDelegate:(NSDictionary *)dic{
    
    _dicFiter = dic;

    [self getSearchResult];
}


- (void)reloadTableViewHeaderView{
    
    

}

@end
