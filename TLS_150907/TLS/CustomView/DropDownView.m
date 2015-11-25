//
//  DropDownView.m
//  自定义下拉菜单
//
//  Created by 屠淋 on 15/9/5.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "DropDownView.h"


@interface DropDownView()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger leftSelectedRow;
    NSInteger rightSelectedRow;
    BOOL _isRefresh;
}
@property (nonatomic, strong) UITableView *leftTaleView;

@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) UIActivityIndicatorView *activityView ;
@end

@implementation DropDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBACOLOR(0, 0, 0, 0.3);
        
        leftSelectedRow = 0;
        rightSelectedRow = 0;
        
        UITableView *left = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width /3 , frame.size.height / 3 + 20) style:UITableViewStylePlain];
        
        left.delegate = self;
        left.dataSource = self;
        left.tableFooterView = [[UIView alloc]init];
        left.backgroundColor = UIColorFromRGB(0xe9e9e9);
        left.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);

        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:leftSelectedRow inSection:0];
        [left selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        [self addSubview:left];
        self.leftTaleView = left;
        
        UITableView *right = [[UITableView alloc]initWithFrame:CGRectMake(frame.size.width /3, 0, frame.size.width /3 * 2 , frame.size.height/3+20) style:UITableViewStylePlain];
        
        right.delegate = self;
        right.dataSource = self;
        right.layer.borderWidth = 0.5;
        right.layer.borderColor = UIColorFromRGB(0x9a9a9a).CGColor;
        right.tableFooterView = [[UIView alloc]init];
        right.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);

        
        [self addSubview:right];
        self.rightTableView = right;
        
        
        
    }
    return self;
}


#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView == self.leftTaleView) {
        return self.leftArray.count;
    }else{
        return [self.rightArray[leftSelectedRow] count];
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
   
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (tableView == self.leftTaleView) {
        if (indexPath.row == leftSelectedRow) {
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];

        }
        NSDictionary *dic = self.leftArray[indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = dic[@"attribute_lable"];
        cell.textLabel.font = [UIFont systemFontOfSize:11];
        cell.textLabel.numberOfLines = 2;
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = view;
        
    }else{
        
        if (indexPath.row == rightSelectedRow) {
            
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];

        }
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3*2 - 30, 14, 14, 12)];
        imageV.image = [UIImage imageNamed:@"ico_make"];
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 3*2, 0.5)];
        lineView1.backgroundColor = UIColorFromRGB(0x9a9a9a);
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH / 3*2, 0.5)];
        lineView2.backgroundColor = UIColorFromRGB(0x9a9a9a);
        UIView *view = [[UIView alloc]init];
        [view addSubview:imageV];
        [view addSubview:lineView1];
        [view addSubview:lineView2];
        
        cell.selectedBackgroundView = view;
        NSDictionary *dic = self.rightArray[indexPath.row];
        NSString *key = [dic allKeys][0];
        cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)",key,dic[key]];
        cell.textLabel.font = [UIFont systemFontOfSize:11];
        cell.textLabel.numberOfLines = 2;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.leftTaleView == tableView) {
        NSDictionary *dic = self.leftArray[indexPath.row];
        leftSelectedRow = indexPath.row;
        [self requestRightDataWithCode:dic[@"attribute_code"]];
    }else{
        rightSelectedRow = indexPath.row;
        [self hidden];
        NSDictionary *left = self.leftArray[leftSelectedRow];
        NSDictionary *right = self.rightArray[rightSelectedRow];
        
        NSString *key = left[@"attribute_code"];
        NSString *value = right[[[right allKeys] firstObject]];
        NSDictionary *dic = @{key:value};
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(fiterDelegate:)]) {
            [self.delegate fiterDelegate:dic];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 40;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    
}

- (void)reloadSubViews{
    
    if ([self.leftArray count] != 0) {
        [self.leftTaleView reloadData];
        NSDictionary *dic = self.leftArray[0];
        [self requestRightDataWithCode:dic[@"attribute_code"]];
    }
    if ([self.leftArray count] != 0) {
        [self.rightTableView reloadData];
    }

}


#pragma mark - 隐藏 显示

- (void)show{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.frame = CGRectMake(0, 40,  SCREEN_WIDTH, SCREEN_HEIGHT);
        
    }];

}

- (void)hidden{
    
//    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, - SCREEN_HEIGHT,  SCREEN_WIDTH, SCREEN_HEIGHT);
        
//    }];
}

- (void)showProgressHUD{
    
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.height);
    
    UIActivityIndicatorView *avtivityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    avtivityView.frame = CGRectMake(self.width/2 - 20, self.height / 6 - 20, 40, 40);
    [view addSubview:avtivityView];
    self.activityView = avtivityView;

    [self addSubview:view];
    [avtivityView startAnimating];
}
- (void)hiddenProgress{
    [self.activityView stopAnimating];
}


- (void)requestRightDataWithCode:(NSString*)code{
    

    [self showProgressHUD];

    self.leftTaleView.userInteractionEnabled = NO;
    //mobile.ltsecurityinc.com/api2/products/filterRight?categoryid=45&attributecode=ndvr_housing
    NSDictionary *dic = @{@"categoryid":mAvailableString(self.categoryid),
                          @"attributecode":mAvailableString(code)};
    [Networking GetAFNRequestWithParameters:dic andHttpType:@"products" action:@"filterRight" withSuccessBlock:^(id dicResult) {
        NSLog(@"请求成功:%@",dicResult);
        self.leftTaleView.userInteractionEnabled = YES;

        self.rightArray = dicResult[@"data"];
        [self.rightTableView reloadData];
        [self hiddenProgress];
        
    } withErrorBlock:^(id dicResult, NSString *error) {
        NSLog(@"请求失败:%@",dicResult);
        [self hiddenProgress];
        self.leftTaleView.userInteractionEnabled = YES;

    }];

}


@end
