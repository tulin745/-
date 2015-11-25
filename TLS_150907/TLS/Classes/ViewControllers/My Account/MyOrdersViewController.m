//
//  MyOrdersViewController.m
//  TLS
//
//  Created by newtouch on 15/8/20.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "MyOrdersViewController.h"
#import "OrderTableViewCell.h"
#import "UserInfo.h"

@interface MyOrdersViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *titleArray;
    int pageindex;
    NSString *orderStaut;
    NSInteger selectedBtn;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *topBtn;


@property (nonatomic, strong) NSMutableDictionary *requestDic;

@property (nonatomic, strong) NSMutableArray *dataAry;

@property (strong, nonatomic) NSMutableArray *arrayBtn;
@end

@implementation MyOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Orders";
    // Do any additional setup after loading the view from its nib.
    [self creatButtonTabBarTexts:@[@"All",@"Pending Payment",@"Payment",@"Complete"]];
    
    orderStaut = @"";
    selectedBtn = 0;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    pageindex = 1;

    _dataAry = [NSMutableArray array];
    [self setupRefresh];
    
}

- (IBAction)topBtnClieck:(UIButton *)sender {
    [_tableView setContentOffset:CGPointMake(0,0) animated:YES];
}

- (void)requestData:(int)pageIndex{
    _requestDic = [NSMutableDictionary dictionary];
    
    //接口变动
    UserInfo *userInfo = [HomeShareInfo sharedHomeInfoModel].userInfo;
    [_requestDic setObject:userInfo.email forKey:@"customeremail"];
    NSString *pagesize = [NSString stringWithFormat:@"%d",pageIndex];
    [_requestDic setObject:pagesize forKey:@"pageindex"];
    [_requestDic setObject:@"10" forKey:@"pagesize"];
    [_requestDic setObject:userInfo.customerid forKey:@"customerid"];
    [_requestDic setObject:orderStaut forKey:@"orderstatus"];
    
    [Networking GetAFNRequestWithParameters:_requestDic andHttpType:@"orders" action:@"list" withSuccessBlock:^(id dicResult) {
        NSLog(@"request%@",dicResult);

       NSArray *requstAry = [dicResult objectForKey:@"data"];
       if (pageIndex>1) {
           
           [_dataAry addObjectsFromArray:requstAry];

           [self.tableView reloadData];

           [self.tableView footerEndRefreshing];
       }else{
          
           _dataAry = [requstAry mutableCopy];
           
           [self.tableView reloadData];

           [self.tableView headerEndRefreshing];
       }
       pageindex += 1;

   } withErrorBlock:^(id dicResult, NSString *error) {
       [self.view alertViewShowWithMessage:dicResult[@"message"] View:self.navigationController.view];
       NSLog(@"OrdersRequest Error:%@",error);
       [self.tableView headerEndRefreshing];
       [self.tableView footerEndRefreshing];
       
   }];
    

}

- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
//    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"Drop-down to refresh";
//    self.tableView.headerReleaseToRefreshText = @"Losson begin to refresh";
//    self.tableView.headerRefreshingText = @"refreshing";
//    
//    self.tableView.footerPullToRefreshText = @"Pull-up can load more data";
//    self.tableView.footerReleaseToRefreshText = @"Losson begin to load more data";
//    self.tableView.footerRefreshingText = @"loading";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    pageindex = 1;
    // 1.请求数据
    [self requestData:pageindex];

}

- (void)footerRereshing
{
    // 1.添加假数据
    [self requestData:pageindex];
   
}

#pragma mark -
#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataAry.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *order = _dataAry[section];
    NSArray *items = [order objectForKey:@"items"];
    return items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"OrderTableViewCell";
    
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = NIB_Load(@"OrderTableViewCell");
    }
    
    NSDictionary *order = _dataAry[indexPath.section];
    NSArray *items = [order objectForKey:@"items"];
    NSDictionary *product = items[indexPath.row];
    
    Images *info = [HomeShareInfo sharedHomeInfoModel].HomeClass.images;
    [cell.commodityImage sd_setImageWithURL:[NSURL URLWithString:info.whatsNewIcon]];
    
    cell.commodityName.text = [product objectForKey:@"ProductName"];
    cell.commodityPrice.text =[NSString stringWithFormat:@"$%.2f",[[product objectForKey:@"Price"] floatValue]];
    cell.commoditCount.text = [NSString stringWithFormat:@"x%ld",[[product objectForKey:@"Qty"] integerValue]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 40;
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSDictionary *order = _dataAry[section];

    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    
    UIView *labView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    labView.backgroundColor = UIColorFromRGB(0xEBEBEB);
    [backgroundView addSubview:labView];
    
    UILabel *CreatedAt = [[UILabel alloc]initWithFrame:CGRectMake( 15 , 0 , SCREEN_WIDTH, 30)];
    CreatedAt.text = [NSString stringWithFormat:@"%@",[order objectForKey:@"CreatedAt"]];
    CreatedAt.textColor = UIColorFromRGB(0xa0a0a0);
    CreatedAt.font = [UIFont systemFontOfSize:11];
    [backgroundView addSubview:CreatedAt];
    
    UILabel *orderNO = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH/3*2, 20)];
    orderNO.text = [NSString stringWithFormat:@"Order NO:%@",[order objectForKey:@"IncrementId"]];
    orderNO.font = [UIFont systemFontOfSize:15];
    
    UILabel *orderStatus = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2+15, 10, SCREEN_WIDTH/3-30, 20)];
    orderStatus.text = [NSString stringWithFormat:@"%@",[order objectForKey:@"Status"]];
    if ([orderStatus.text isEqualToString:@"pending"]) {
        orderStatus.backgroundColor = UIColorFromRGB(0xce3530);
    }else if([orderStatus.text isEqualToString:@"complete"]){
        orderStatus.backgroundColor = UIColorFromRGB(0x5bad0d);
    }else{
        orderStatus.backgroundColor = UIColorFromRGB(0xdcdcdc);
    }
    
    orderStatus.textColor = [UIColor whiteColor];
    orderStatus.font = [UIFont systemFontOfSize:9];
    orderStatus.textAlignment = NSTextAlignmentCenter;
    
    NSString *text = orderStatus.text;
    CGRect frame = [text boundingRectWithSize:CGSizeMake(0, 20) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:orderStatus.font} context:nil];
    
    orderStatus.width = frame.size.width + 15;
    orderStatus.x = SCREEN_WIDTH - orderStatus.width - 15;
    
    UIView *backgrandView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 39)];
    backgrandView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 38, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xe9e9e9);
    
    [backgrandView addSubview:lineView];
    [backgrandView addSubview:orderNO];
    [backgrandView addSubview:orderStatus];
    
    [backgroundView addSubview:backgrandView];
    return backgroundView;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    
//    NSDictionary *order = _dataAry[section];
//    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, tableView.sectionFooterHeight)];
//    sectionView.backgroundColor = [UIColor whiteColor];
//    
//    UILabel *orderNO = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH/3*2, 20)];
//    orderNO.text = [NSString stringWithFormat:@"%@",[order objectForKey:@"CreatedAt"]];
//    orderNO.font = [UIFont systemFontOfSize:15];
//    
//    UILabel *orderTotal = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2+15, 10, SCREEN_WIDTH/3-30, 20)];
//    NSArray *items = [order objectForKey:@"items"];
//    double sum = 0;
//    for (NSDictionary *dic in items) {
//        sum = [dic[@"RowTotal"] doubleValue] + sum;
//    }
//    orderTotal.text = [NSString stringWithFormat:@"Total:$%.2f",sum];
//   
//    orderTotal.font = [UIFont systemFontOfSize:14];
//    orderTotal.textAlignment = NSTextAlignmentCenter;
//    
//    NSString *text = orderTotal.text;
//    CGRect frame = [text boundingRectWithSize:CGSizeMake(0, 20) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:orderTotal.font} context:nil];
//    
//    orderTotal.width = frame.size.width + 15;
//    orderTotal.x = SCREEN_WIDTH - orderTotal.width - 15;
//    
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
//    lineView.backgroundColor = UIColorFromRGB(0xe9e9e9);
//    
//    [sectionView addSubview:orderNO];
//    [sectionView addSubview:orderTotal];
//    [sectionView addSubview:lineView];
//
//    return sectionView;
//}


- (void)creatButtonTabBarTexts:(NSArray* )texts{
    
    titleArray = texts;
    _arrayBtn = [[NSMutableArray alloc] initWithCapacity:[texts count]];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    for (int i = 0;  i < texts.count ; i++) {
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:Color_RGB(255, 0, 0) forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:texts[i] forState:UIControlStateNormal];
        if (i == 0) {
            button.selected = YES;
        }
        
        button.titleLabel.font = SCREEN_WIDTH == 320 ? [UIFont systemFontOfSize:9] : [UIFont systemFontOfSize:11];
        button.frame = CGRectMake(i * SCREEN_WIDTH / texts.count, 0, SCREEN_WIDTH / texts.count, 35);
        button.tag = i;
        [button setBackgroundColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [_arrayBtn addObject:button];
        
    }
    
    UIView *viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, 34, SCREEN_WIDTH, 1)];
    viewLine.backgroundColor = UIColorFromRGB(0xe9e9e9);
    [view addSubview:viewLine];
    [self.view addSubview:view];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 200){
        _topBtn.hidden = YES;
    }else{
        _topBtn.hidden = NO;
    }
}

- (void)titleButtonClick:(UIButton*)btn{
    btn.selected = YES;
    for (UIButton *subBtn in _arrayBtn) {
        if (subBtn != btn) {
            subBtn.selected = NO;
        }
    }
    if (selectedBtn == btn.tag) {
        return;
    }else{
        selectedBtn = btn.tag;
    }
    
    switch (btn.tag) {
        case 0:
        {
            orderStaut = @"";

        }
            break;
        case 1:
        {
            orderStaut = @"pending";
            
        }
            break;
            case 2:
        {
            orderStaut = @"payment";

        }
            break;
        default:
        {
            orderStaut = @"complete";
        }
            break;
    }
    
    [_dataAry removeAllObjects];
    
    [self requestData:pageindex];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
