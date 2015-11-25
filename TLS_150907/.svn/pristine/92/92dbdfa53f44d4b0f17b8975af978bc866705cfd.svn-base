//
//  KnowledgeView.m
//  TLS
//
//  Created by 屠淋 on 15/9/11.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "KnowledgeView.h"

#import "KnowledgeTableViewCell.h"
#import "Know.h"

@interface KnowledgeView()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain) NSMutableArray *dataArray;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,assign) BOOL isShow;
@property (nonatomic,strong) NSMutableArray *imageViews;
@property (nonatomic, strong) NSMutableArray *headViews;
@end

@implementation KnowledgeView

- (NSMutableArray *)headViews{
    if (!_headViews) {
        _headViews = [NSMutableArray array];
    }
    return _headViews;
}
- (NSMutableArray *)imageViews{
    if (!_imageViews) {
        _imageViews = [NSMutableArray array];
    }
  return _imageViews;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self loadData];
    
}

- (void)loadData{
    // 全局的数据源
    _dataArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dic = [[HomeShareInfo sharedHomeInfoModel].HomeClass.knowledgebase mutableCopy];
    
    if (dic) {
        NSArray *keys = [dic allKeys];
        for (NSString *key in keys) {
            Know *info = [[Know alloc]init];
            info.array = dic[key];
            info.name = key;
            [_dataArray addObject:info];
        }
        
    }

    [self headerViewForTableView];
    
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    Know *info = _dataArray[section];
    
    if ([info isShow]) {
        return info.array.count;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdntifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdntifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdntifier];
    }
    Know *data = [_dataArray objectAtIndex:indexPath.section];
    NSDictionary *dic = [[data array] objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"article_name"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 53;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

// 定义头标题的视图，添加点击事件
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = self.headViews[section];
    return headView;

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
    
}

- (void) btnClick:(UIButton *)btn
{
    Know *data = [_dataArray objectAtIndex:btn.tag];
    
    for (int i = 0; i < self.imageViews.count; i ++ ) {
        UIImageView *imageV = self.imageViews[i];
        if (i == btn.tag) {
            imageV.highlighted = !imageV.highlighted;
        }
    }
    // 改变组的显示状态
    data.isShow = !data.isShow;
//    // 刷新点击的组标题，动画使用卡片
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - headerView

- (void)headerViewForTableView{
    
    for (int i = 0; i < self.dataArray.count; i ++ ) {
        
        Know *data = _dataArray[i];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        view.backgroundColor = UIColorFromRGB(0xfafafa);
        
        //剪头
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(SCREEN_WIDTH - 35 , 12.5,  15, 15);
        imageView.image = [UIImage imageNamed:@"sj-xia"];
        imageView.highlightedImage = [UIImage imageNamed:@"sj-shang"];
        [self.imageViews addObject:imageView];//数组 保存所有的imageView
        
        //title
        UILabel *questionLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 40)];
        
        int dataCount = 0;
        
        for (int i = 0 ; i < data.array.count ; i++) {
            dataCount ++;
        }
        
        questionLabel.text = [NSString stringWithFormat:@"%@(%d)",data.name,dataCount];
        questionLabel.font = [UIFont systemFontOfSize:15];
        
        //点击按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = questionLabel.frame;
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = UIColorFromRGB(0xc8c8c8);
        
        [view addSubview:lineView];
        [view addSubview:imageView];
        [view addSubview:questionLabel];
        [view addSubview:btn];
        
        [self.headViews addObject:view];
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];

    _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.height - 10);
    
}

@end
