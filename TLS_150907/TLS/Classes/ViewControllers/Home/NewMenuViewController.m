//
//  NewMenuViewController.m
//  TLS
//
//  Created by 屠淋 on 15/9/7.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "NewMenuViewController.h"

#import "HeadView.h"
#import "CategorieInfo.h"

@interface NewMenuViewController ()<UITableViewDataSource,UITableViewDelegate,HeadViewDelegate>
{
    
    NSInteger _currentSection;
    NSInteger _currentRow;
    NSArray *_arrData;
}
@property (strong, nonatomic)  UITableView *tableView;
@property (strong, nonatomic)  UIView *viewT;

@property (nonatomic, strong) NSMutableArray *arrayContent;
@property (nonatomic, strong) NSMutableArray *headViewArray;

@end

@implementation NewMenuViewController

- (NSMutableArray*)arrayContent{
    
    if (!_arrayContent) {
        _arrayContent = [NSMutableArray array];
    }
    return _arrayContent;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSMutableArray *menuArray = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getMenuFilePath]];
    
    NSMutableArray *menu = [HomeShareInfo sharedHomeInfoModel].menuArray;
    
    if ([menu count] != 0) {
        
        self.arrayContent = menu;
        
        
    }else{
        self.arrayContent = menuArray;
        
        [self categoriesRequest];
    }
    
    [self loadModel];
    [self restoreHeadView];
    [self.tableView reloadData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self initView];
    
    
}

- (void)initView{
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 3*2, SCREEN_HEIGHT)];
    view.layer.shadowOffset = CGSizeMake(0, 3);
    view.layer.shadowRadius = 7.0;
    view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    view.layer.shadowOpacity = 0.8;
    view.userInteractionEnabled = YES;
    [self.view addSubview:view];
    self.viewT = view;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH / 3 * 2, SCREEN_HEIGHT - 20) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.userInteractionEnabled = YES;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0);
    [view addSubview:tableView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.width, 40)];
    label.text = @"Categories";
    label.textColor = UIColorFromRGB(0x525252);
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    [headView addSubview:label];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xe9e9e9);
    [headView addSubview:lineView];
    tableView.tableHeaderView = headView;
    
    self.tableView = tableView;
    
    NSLog(@"%@",view.subviews);
}

- (void)loadModel{
    
    _currentRow = -1;
    self.headViewArray = [[NSMutableArray alloc]init ];
    for(int i = 0;i< self.arrayContent.count ;i++)
    {
        NSArray *arr = self.arrayContent[i];
        CategorieInfo *info = arr[0];
        HeadView* headview = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 45)];
        headview.label.text = info.name;
        headview.tag = i;
        headview.arrImages = @[@"cate-down",@"cate-up"];
        headview.delegate = self;
        headview.section = i;
        [self.headViewArray addObject:headview];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.arrayContent.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    HeadView* headView = [self.headViewArray objectAtIndex:section];
    NSArray *arr = self.arrayContent[section];
    NSArray * data  = arr[1];
    return headView.open ? data.count : 0;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSArray *arr = self.arrayContent[indexPath.section];
    NSArray * data  = arr[1];
    CategorieInfo *info = data[indexPath.row];
    
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    UILabel *label = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
       label = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, SCREEN_WIDTH - 20, 44)];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    label.text = info.name;
    label.textColor = UIColorFromRGB(0x3c3c3c);
    label.font = [UIFont systemFontOfSize:14 weight:0.0001f];
    [cell.contentView addSubview:label];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HeadView* headView = [self.headViewArray objectAtIndex:indexPath.section];
    
    return headView.open ? 45 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 45;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self.headViewArray objectAtIndex:section];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    _currentRow = indexPath.row;
    //    [_tableView reloadData];
    
    NSArray *arr = self.arrayContent[indexPath.section];
    NSArray * data  = arr[1];
    
    CategorieInfo *info = data[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(menuVC:andInfo:)]) {
        [self.delegate menuVC:self andInfo:info];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - SHOW and Hidden

- (void)show{
    
    [UIView animateWithDuration:0.5 animations:^{
        if (self.view.x == - SCREEN_WIDTH ) {
            self.view.x = 0;
        }
        
    }];
    
    
}

- (void)hidden{
    
    [UIView animateWithDuration:0.5 animations:^{
        [self restoreHeadView];
        if (self.view.x == 0) {
            
            self.view.x = - SCREEN_WIDTH;
            
        }
        
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    UIView *view = touch.view;
    if (view == self.view) {
        [self hidden];
    }
    
}

#pragma mark - Request

- (void)categoriesRequest{//菜单栏
    
    if (self.arrayContent.count == 0) {
        [self.viewT showProgressHUDWithInfo:alert_Loading];
    }
    [Networking getRequestWithHTTPName:categories_Request withSuccessBlock:^(NSArray *arrResult) {
        NSLog(@"request success:%@",arrResult);
        [self.viewT hiddenProgressHUD];
        NSArray *arr = [CategorieInfo objectArrayWithKeyValuesArray:arrResult];
        
        [self sortingDataWith:arr];
        
    } withErrorBlock:^(NSDictionary *dicResult, NSString *error) {
        NSLog(@"request failed:%@",dicResult[@"NSLocalizedDescription"]);
        
        [self.viewT hiddenProgressHUD];
    }];
    
}


- (void)sortingDataWith:(NSArray*)array{
    
    self.arrayContent = [NSMutableArray array];
    
    for (CategorieInfo *info in array) {
        
        if ([info.children_ids length] != 0) {
            NSArray * arrchildrenIds  = [info.children_ids componentsSeparatedByString:@","];
            NSMutableArray *arr = [NSMutableArray array];
            NSMutableArray *arr0 = [NSMutableArray array];
            
            for (NSString *childrenId in arrchildrenIds) {
                for (CategorieInfo *childInfo in array) {
                    if ([childInfo.entity_id isEqualToString:childrenId]) {
                        [arr addObject:childInfo];
                    }
                }
            }
            [arr0 addObject:info];
            [arr0 addObject:arr];
            [self.arrayContent addObject:arr0];
        }
        
    }
    
    for (int i = 0; i < self.arrayContent.count ; i ++) {
        NSMutableArray * arr0 = self.arrayContent[i];
        CategorieInfo *info  = [arr0 objectAtIndex:0];
        
        if (info.name == [NSNull null] ) {
            [self.arrayContent removeObject:arr0];
        }
        NSArray *arr = [arr0 objectAtIndex:1];
        
        for (CategorieInfo* key in arr) {
            
            if (key.name == [NSNull null]) {
                [self.arrayContent removeObject:arr0];
            }
        }
    }
    [self.arrayContent removeObjectAtIndex:0];
    
    [NSKeyedArchiver archiveRootObject:self.arrayContent toFile:[self getMenuFilePath]];

    
    [HomeShareInfo sharedHomeInfoModel].menuArray = self.arrayContent;
    
    [self loadModel];
    [self.tableView reloadData];
}

- (void)restoreHeadView{
    
    for(int i = 0;i<[self.headViewArray count];i++)
    {
        HeadView *head = [self.headViewArray objectAtIndex:i];
        if (head.open) {
            head.open = NO;
            head.buttonV.selected = NO;
        }
    }
    [self.tableView reloadData];
    
}

#pragma mark - HeadViewdelegate

-(void)selectedWith:(HeadView *)view andBtn:(UIButton *)btn{
    
    if (btn.tag == 10000) {
        
        NSArray *arr = self.arrayContent[view.tag];
        CategorieInfo *info = arr[0];
        
        if ([self.delegate respondsToSelector:@selector(menuVC:andInfo:)]) {
            [self.delegate menuVC:self andInfo:info];
        }
        
    }else{
        
        _currentRow = -1;
        if (view.open) {
            for(int i = 0;i<[self.headViewArray count];i++)
            {
                HeadView *head = [self.headViewArray objectAtIndex:i];
                head.open = NO;
                head.buttonV.selected = NO;
                
            }
            [_tableView reloadData];
            return;
        }
        _currentSection = view.section;
        [self reset];
        
    }
    
    
}

//界面重置
- (void)reset
{
    for(int i = 0;i<[self.headViewArray count];i++)
    {
        HeadView *head = [self.headViewArray objectAtIndex:i];
        
        if(head.section == _currentSection)
        {
            head.open = YES;
            head.buttonV.selected = YES;
        }else {
            head.buttonV.selected = NO;
            
            head.open = NO;
        }
        
    }
    [_tableView reloadData];
}


- (NSString*)getMenuFilePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"MenuList.plist"];
    return filePath;
}



@end
