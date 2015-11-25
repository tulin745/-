//
//  ContactViewController.m
//  TLS
//
//  Created by 屠淋 on 15/8/8.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "ContactViewController.h"
#import "ContactTableViewCell.h"

#import "NewMenuViewController.h"
#import "SearchResultViewController.h"
@interface ContactViewController ()<UITableViewDataSource,UITableViewDelegate,NewMenuViewControllerDelegate>

@property (strong, nonatomic) BaseClass *homeInfo;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataAry;

@property (nonatomic, strong)  NewMenuViewController *menuViewController;
@end

@implementation ContactViewController

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
    self.navigationItem.title = @"Contact";
    NSLog(@"dddd");
    [self setMenuLeftItem];

    [self setShopRightItem];
    [self setupRefresh];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionIndexBackgroundColor = [UIColor clearColor];

}

- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"Drop-down to refresh";
    self.tableView.headerReleaseToRefreshText = @"Losson begin to refresh";
    self.tableView.headerRefreshingText = @"refreshing";
    
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{

    [self configRequest];
    
}
-(void)loadData{
    
    _homeInfo = [HomeShareInfo sharedHomeInfoModel].HomeClass;
    _dataAry = _homeInfo.contacts;
    
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataAry.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifer = @"contactCell";
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    NSDictionary *companyDic = [_dataAry[indexPath.section] dictionaryRepresentation];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ContactTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            cell.titleStr.text = [companyDic objectForKey:@"addr1"];
            [cell.callTellbtn removeFromSuperview];
            break;
        case 1:
            cell.titleStr.text = [companyDic objectForKey:@"addr2"];
            [cell.callTellbtn removeFromSuperview];
            break;
        case 2:
            cell.titleStr.text = [NSString stringWithFormat:@"Toll Free:%@", [companyDic objectForKey:@"toll_free"]];
            [cell.callTellbtn removeFromSuperview];
            break;
        case 3:
            cell.titleStr.text = [NSString stringWithFormat:@"Tel:%@", [companyDic objectForKey:@"tel"]];
            break;
        case 4:
            cell.titleStr.text = [NSString stringWithFormat:@"Fax:%@", [companyDic objectForKey:@"fax"]];
            [cell.callTellbtn removeFromSuperview];
            break;
        case 5:
            cell.titleStr.text = [NSString stringWithFormat:@"Email:%@", [companyDic objectForKey:@"email"]];
            [cell.callTellbtn removeFromSuperview];
            break;
        case 6:
            cell.titleStr.text = [NSString stringWithFormat:@"Hours:%@", [companyDic objectForKey:@"hours"]];
            [cell.callTellbtn removeFromSuperview];
            break;
        case 7:
            cell.titleStr.text = [NSString stringWithFormat:@"Note:%@", [companyDic objectForKey:@"note"]];
            [cell.callTellbtn removeFromSuperview];
            break;
        case 8:
            cell.titleStr.text = [NSString stringWithFormat:@"Office:%@", [companyDic objectForKey:@"office"]];
            [cell.callTellbtn removeFromSuperview];
            break;
        default:
            break;
    }
    
    UIImageView *separatorlineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-2, SCREEN_WIDTH, 2)];
    separatorlineView.image = [UIImage imageNamed:@"separatorline"];
    if (indexPath.row != companyDic.count - 1) {
        [cell.contentView addSubview:separatorlineView];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 42;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(1, 0, SCREEN_WIDTH, 42)];
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(1, 0, SCREEN_WIDTH, 40)];
    sectionView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH, 30)];
    NSDictionary *companyDic = [_dataAry[section] dictionaryRepresentation];
    titleLabel.text = [companyDic objectForKey:@"office"];
    [sectionView addSubview:titleLabel];
    [bgView addSubview:sectionView];
    return bgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - ConfigRequest

- (void)configRequest{//基本数据
    
    
    [Networking getRequestWithHTTPName:config_Request withSuccessBlock:^(NSDictionary *dicResult) {
        NSLog(@"request success:%@",dicResult);
        [self.tableView headerEndRefreshing];
        [self saveLocalWithDic:dicResult];//保存本地数据
        
        [HomeShareInfo sharedHomeInfoModel].HomeClass = [BaseClass modelObjectWithDictionary:dicResult];
        self.homeInfo = [HomeShareInfo sharedHomeInfoModel].HomeClass;
        
        [self loadData];
        
    } withErrorBlock:^(NSDictionary *dicResult, NSString *error) {
        NSLog(@"request failed:%@",dicResult);
        [self.tableView headerEndRefreshing];
        [self readData];
        [self loadData];
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