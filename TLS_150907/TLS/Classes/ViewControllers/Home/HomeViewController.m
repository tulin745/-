//
//  HomeViewController.m
//  TLS
//
//  Created by 屠淋 on 15/8/8.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeMiddleTableViewCell.h"
#import "HomeFooterTableViewCell.h"
#import "REFrostedViewController.h"
#import "NewMenuViewController.h"
#import "UIView+REFrostedViewController.h"
#import "CustomNavViewController.h"
#import "HeadView.h"
#import "SeachTextFeild.h"
#import "Images.h"
#import "ShopCartView.h"
#import "SGFocusImageFrame.h"
#import "SGFocusImageItem.h"
#import "SearchResultViewController.h"
#import "OpenFileViewController.h"
#import "ProductListViewController.h"

@interface HomeViewController ()<SGFocusImageFrameDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,HomeMiddleTableViewCellDelegate,HomeFooterTableViewCellDelegate,NewMenuViewControllerDelegate,SGFocusImageFrameDelegate>
{
    NSInteger _currentSection;
    NSInteger _currentRow;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) BaseClass *homeInfo;

@property (nonatomic, strong) NSMutableArray *arrayContent;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) NewMenuViewController *menuViewController;

@property (nonatomic, strong) SGFocusImageFrame *scrollView;

@property (nonatomic, strong) NSMutableDictionary *ipDic;
@property (nonatomic, strong) NSMutableDictionary *HDTVDic;

@property (nonatomic, strong) NSMutableArray *PDFArray;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    if ([[HomeShareInfo sharedHomeInfoModel] isThroughAudit]) {
        [self setShopRightItem];
    }else{
        self.navigationItem.rightBarButtonItem = nil;
    }
    [super viewWillAppear:animated];
}

- (NSMutableArray*)PDFArray{
    
    if(!_PDFArray){
        _PDFArray = [NSMutableArray array];
    }
    
    return _PDFArray;
}

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

- (NSMutableArray*)arrayContent{
    
    if (!_arrayContent) {
        _arrayContent = [NSMutableArray array];
    }
    return _arrayContent;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.homeInfo = [HomeShareInfo sharedHomeInfoModel].HomeClass;
    
    [self setMenuLeftItem];

    self.tableView.tableFooterView = [[UIView alloc]init];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nav-logo"]];
    imageView.frame = CGRectMake(0,0, 90, 25);
    
    self.navigationItem.titleView = imageView;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TableViewReloadData) name:@"HomeInfoSccess" object:nil];

    [self getIpFile];
    
    [self.tableView addHeaderWithTarget:self action:@selector(configRequest)];
    
}

- (void)loadPicturewithView:(UIView*)superView{
    
    Images *imageInfo = [HomeShareInfo sharedHomeInfoModel].HomeClass.images;
    NSDictionary *bannerImages = imageInfo.sliding;
    
    NSArray *keys = [bannerImages allKeys];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *arr = [NSMutableArray array];

    for (NSString *key in keys) {
        NSDictionary *dicSub = @{@"title":@"",@"PicUrl":bannerImages[key]};
        [arr addObject:dicSub];
    }
    
    [dic setObject:arr forKey:@"ResponseData"];
    
//    NSDictionary *dic= @{@"ResponseData":
//                             @[@{@"Title":@"",@"PicUrl":@"http://a4.att.hudong.com/16/27/19300001317260131200271451486_950.jpg"},
//                               @{@"Title":@"",@"PicUrl":@"http://www.xaecong.com/uploadfile/2015-4/20150404195911560.jpg"},
//                               @{@"Title":@"",@"PicUrl":@"http://a4.att.hudong.com/16/27/19300001317260131200271451486_950.jpg"},
//                               @{@"Title":@"",@"PicUrl":@"http://www.xaecong.com/uploadfile/2015-4/20150404195911560.jpg"}]};
    
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
    
    CGFloat height = 0;
    if (SCREEN_WIDTH == 320) {
        height = 200;
    }else if(SCREEN_WIDTH == 375){
        height = 255;
    }else{
        height = 300;
    }
    
    SGFocusImageFrame *view = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, height - 50) delegate:self imageItems:itemArray];
    
    [superView addSubview:view];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;

}

-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    switch (indexPath.section) {
        case 0:
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            SeachTextFeild *textF = [[SeachTextFeild alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH - 40, 30)];
            [cell.contentView addSubview:textF];
            textF.returnKeyType = UIReturnKeySearch;
            textF.delegate = self;
            
            [self loadPicturewithView:cell.contentView];
            [cell setNeedsDisplay];
            return cell;
        }
            break;
        case 1:
        {
            HomeMiddleTableViewCell *cell = [[HomeMiddleTableViewCell alloc]init];
            cell.delegate = self;
            cell.imageInfo = self.homeInfo.images;
            [cell setNeedsLayout];
            return cell;
        }
            break;
            case 2:
        {
            HomeFooterTableViewCell *cell = NIB_Load(@"HomeFooterTableViewCell");
            cell.version = self.PDFArray;
            cell.delegate = self;
            return cell;
        }
            break;
        default:
            return cell;
            break;
    }
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.section == 0) {
        
        if (SCREEN_WIDTH == 320) {
            return 200;
        }else if(SCREEN_WIDTH == 375){
            return 255;
        }else{
            return 300;
        }
    }else{
        
        if (SCREEN_WIDTH == 375) {
            return 147;
        }else if (SCREEN_WIDTH == 414){
            return 159;
        }
        return 125;
        
    
    }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
        {
            return 0;
        }
            break;
        case 1:
        {
            return 4;
        }
            break;
            
        default:
        {
            return 8;
        }
            break;
    }
    
}



#pragma mark - HomeMiddleTableViewCellDelegate

- (void)HomeMiddleCell:(UIButton *)btn{
    
    if (btn.tag == 10) {//what's new
        
        SearchResultViewController *searchVC = [[SearchResultViewController alloc]initWithNibName:@"SearchResultViewController" bundle:nil];
        searchVC.title = @"What's new";
        [self.navigationController pushViewController:searchVC animated:YES];

    }else{
        ProductListViewController *productlistVC = [[ProductListViewController alloc]init];

        productlistVC.promotionArray = self.homeInfo.promotions;
        [self.navigationController pushViewController:productlistVC animated:YES];
    }
    
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    SearchResultViewController *searchVC = [[SearchResultViewController alloc]initWithNibName:@"SearchResultViewController" bundle:nil];
    
    searchVC.title = textField.text;
    searchVC.searchValue = textField.text;
    [self.navigationController pushViewController:searchVC animated:YES];
    
    return YES;

}


#pragma mark - HomeFooterTableViewCellDelegate

- (void)openFileAction:(UIButton *)button{
    
    OpenFileViewController *openVC = [[OpenFileViewController alloc]init];
    
    if (button.tag == 1000) {
        openVC.title = @"IP Solutions";
        openVC.filePath = [SavePathUtil getIPPDFPath];
        openVC.fileName = @"IP-PDF.pdf";
        openVC.downloadPath = self.ipDic[@"url"];
    }else{
        openVC.fileName = @"HDTV-PDF.pdf";
        openVC.title = @"HD TVI Solutions";
        openVC.downloadPath = self.HDTVDic[@"url"];
        openVC.filePath = [SavePathUtil getHDTVPath];
    }
    [self.navigationController pushViewController:openVC animated:YES];
 
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

- (void)TableViewReloadData{

    self.homeInfo = [HomeShareInfo sharedHomeInfoModel].HomeClass;

    [self.tableView reloadData];
    
}

#pragma mark - SGFocusImageFrameDelegate

- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(SGFocusImageItem *)item{
    
    
}


- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame currentItem:(int)index{
    
    

}


#pragma mark - request

- (void)getIpFile{
    
    [self.view showProgressHUDWithInfo:alert_Loading];
    [Networking getRequestWithHTTPName:@"ip" withSuccessBlock:^(id dicResult) {
        NSLog(@"request success:%@",dicResult);

        self.ipDic = dicResult;
        [JXUserDefault setObjectValue:dicResult forKey:@"IP_PDF"];
        [self getHDTV];
        
    } withErrorBlock:^(id dicResult, NSString *error) {
        NSLog(@"请求失败: %@",dicResult);
        [self.view alertViewShowWithMessage:dicResult[@"message"] View:self.navigationController.view];
        [self.view hiddenProgressHUD];

    }];
}

- (void)getHDTV{

    [Networking getRequestWithHTTPName:@"hdtvi" withSuccessBlock:^(id dicResult) {
        NSLog(@"request success:%@",dicResult);
        [self.view hiddenProgressHUD];
        self.HDTVDic = dicResult;
        [JXUserDefault setObjectValue:dicResult forKey:@"HDTV_PDF"];
        [self PDFData];
        
    } withErrorBlock:^(id dicResult, NSString *error) {
        NSLog(@"请求失败: %@",dicResult);
        [self.view alertViewShowWithMessage:dicResult[@"message"] View:self.navigationController.view];
        [self.view hiddenProgressHUD];
    }];

}

- (void)PDFData{
    
    [self.PDFArray addObject:self.ipDic[@"version"]];
    [self.PDFArray addObject:self.HDTVDic[@"version"]];
    
    [self.tableView reloadData];
}


#pragma mark - ConfigRequest

- (void)configRequest{//基本数据
    
    [self getIpFile];
    
    [Networking getRequestWithHTTPName:config_Request withSuccessBlock:^(NSDictionary *dicResult) {
        NSLog(@"request success:%@",dicResult);
        [self.tableView headerEndRefreshing];
        [self saveLocalWithDic:dicResult];//保存本地数据
        
        [HomeShareInfo sharedHomeInfoModel].HomeClass = [BaseClass modelObjectWithDictionary:dicResult];
        self.homeInfo = [HomeShareInfo sharedHomeInfoModel].HomeClass;

        [self.tableView reloadData];
    } withErrorBlock:^(NSDictionary *dicResult, NSString *error) {
        NSLog(@"request failed:%@",dicResult);
        [self.tableView headerEndRefreshing];
        [self readData];
        [self.tableView reloadData];
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
