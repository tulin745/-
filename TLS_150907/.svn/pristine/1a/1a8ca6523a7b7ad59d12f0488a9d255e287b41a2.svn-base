//
//  ToolsViewController.m
//  TLS
//
//  Created by newtouch on 15/8/22.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "ToolsViewController.h"
#import "ToolSelectedCell.h"
#import "ToolTextFCell.h"
#import "ToolResultCell.h"

@interface ToolsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_arrayData;
    NSArray *_arraySection;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _arrayData = @[@[@"H.264(LTS DVR)",@"MPEG-4"],
                   @[@"CIF (352×240)",@"HD1 (704×240)",@"D1 (704×480)",@"1.3 Megapixel (1280×1024)",@"2.1 Megapixel (1920×1980)",@"3 Megapixel (2048×1536)"],
                   @[@"Highest",@"Normal",@"Low"],
                   @[@"Average Frame Size",@"Number of Cameras",@"Frame Rate per Camera",@"Hours Each Camera Will Record per Day"],
                   @[@"Desired Storage(Number of Days) per Camera",@"Total Bandwidth Required",@"Per Camera",@"Estimated Storage"]];
    _arraySection = @[@"Camera Stream",@"Camera Resolution",@"Video Quality"];
    
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    
    return _arraySection.count + 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = _arrayData[section];
    return arr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    NSArray *arr = _arrayData[indexPath.section];

    if (indexPath.section < 3) {
        static NSString *cellIdentifier = @"ToolSelectedCell";
        ToolSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = NIB_Load(@"ToolSelectedCell");
        }
        [cell.button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        if (indexPath.row == 0) {
            [cell.button setImage:[UIImage imageNamed:@"kuang-moren"] forState:UIControlStateNormal];
        }else{
            [cell.button setImage:[UIImage imageNamed:@"kuang"] forState:UIControlStateNormal];
        }
        cell.titleLabel.text = arr[indexPath.row];
        return cell;
    }else if(indexPath.section == 3){
        static NSString *cellIdentifier = @"ToolTextFCell";
        ToolTextFCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = NIB_Load(@"ToolTextFCell");
        }
        cell.titleLabel.text = arr[indexPath.row];
        return cell;
    }else{
        
        static NSString *cellIdentifier = @"ToolResultCell";
        ToolResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = NIB_Load(@"ToolResultCell");
        }
        return cell;
    
    }
    
    
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    headView.backgroundColor = Color_RGB(240, 240, 240);
    if (section < 3) {
        headView.height = 60;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH / 2, 60)];
        label.font = [UIFont boldSystemFontOfSize:17];
        label.text = _arraySection[section];
        [headView addSubview:label];
    }else{
        headView.height = 10;
    }
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section < 3) {
        return 60;

    }
    return 10;

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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = 60;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

- (void)selectAction:(UIButton*)button{
    [button setImage:[UIImage imageNamed:@"kuang"] forState:UIControlStateNormal];

    button.selected = !button.selected;

}
@end
