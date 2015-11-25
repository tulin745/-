//
//  KnowledgeViewController.m
//  TLS
//
//  Created by newtouch on 15/8/22.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "KnowledgeViewController.h"
#import "KnowledgeTableViewCell.h"
#import "Know.h"

@interface KnowledgeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain) NSMutableArray *dataArray;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,assign) BOOL isShow;
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation KnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 30;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self loadData];
}

- (void)loadData{
    // 全局的数据源
    _dataArray = [[NSMutableArray alloc] init];
    
    NSArray *array = [[HomeShareInfo sharedHomeInfoModel].HomeClass.knowledgebase mutableCopy];
    
    if (array) {
        NSDictionary *dicData = [array firstObject];
        NSArray *keys = [dicData allKeys];
        for (NSString *key in keys) {
            Know *info = [[Know alloc]init];
            info.array = dicData[key];
            info.name = key;
            [_dataArray addObject:info];
        }
        
    }
//    // 添加数据
//    for (int i='A'; i<='H'; i++) {
//        Know *myData = [[Know alloc] init];
//        myData.array = [NSMutableArray array];
//        myData.name = [NSString stringWithFormat:@"General:%c",i];
//        for (int j=0; j<10; j++) {
//            
//            NSString *question = @"Field of View Chart";
//            NSString *date = @"May 4,2014";
//            NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:question,@"question",date,@"date", nil];
//            
//            [myData.array addObject:datadic];
//        }
//        [_dataArray addObject:myData];
//    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Know *array = _dataArray[section];
    
    if ([array isShow]) {
        NSLog(@"%ld",[[array array]count]);
        return [[array array] count];
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
    cell.textLabel.text = [dic objectForKey:@"name"];
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
    Know *data = _dataArray[section];
    UILabel *question = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 40)];
    question.text = data.name;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = question.frame;
    btn.tag = section;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = UIColorFromRGB(0xfafafa);
    _imageView = [[UIImageView alloc]init];
    _imageView.frame = CGRectMake(SCREEN_WIDTH - 35 , 12.5,  15, 15);
    
    if ([data isShow]) {
        _imageView.image = [UIImage imageNamed:@"sj-xia"];
    }else{
        _imageView.image = [UIImage imageNamed:@"sj-shang"];
    }
    
    /*
    if (section%2) {
        btn.backgroundColor = [UIColor darkGrayColor];
    }else{
        btn.backgroundColor = [UIColor lightGrayColor];
    }
     */
    [btn addSubview:_imageView];
    [btn addSubview:question];
    return btn;
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
    NSLog(@"点击事件");
    Know *data = [_dataArray objectAtIndex:btn.tag];
    // 改变组的显示状态
    if ([data isShow]) {
        [data setIsShow:NO];
    }else{
        [data setIsShow:YES];
    }
    // 刷新点击的组标题，动画使用卡片
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationFade];
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
