//
//  InformationViewController.m
//  TLS
//
//  Created by newtouch on 15/8/16.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "InformationViewController.h"
#import "informationTableViewCell.h"
#import "InfomationTextFTableViewCell.h"
@interface InformationViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    NSString *cellName;
    NSString *textCellName;
    NSInteger tagTextF;
    NSString *cuText;
}
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic, strong) NSArray *dataAry;
@property (nonatomic, strong) NSMutableDictionary * dataDic;
@end

@implementation InformationViewController

- (NSMutableDictionary *)dataDic{

    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    textCellName = NSStringFromClass([InfomationTextFTableViewCell class]);
    cellName = NSStringFromClass([informationTableViewCell class]);
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([informationTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellName];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([InfomationTextFTableViewCell class]) bundle:nil] forCellReuseIdentifier:textCellName];
    
    self.navigationItem.title = [self.informationType isEqualToString:@"Account"] ? @"Account Information" : @"Company Information";
    if ([self.informationType isEqualToString:@"Account"]) {
        self.submitBtn.hidden = YES;
    }
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self getInformation];
    
}

- (void)loadDataWithDic:(NSDictionary *)dic{

    if ([self.informationType isEqualToString:@"Account"]) {
        NSString *name = dic[@"name"];
        NSArray *arrName = [name componentsSeparatedByString:@" "];
        _dataAry = @[@{@"title":@"First Name",@"value":mAvailableString(arrName[0])},
                     @{@"title":@"Last Name",@"value":mAvailableString(arrName[1])},
                     @{@"title":@"Email",@"value":mAvailableString(dic[@"email"])}];
    }else{
        
        _dataAry = @[@{@"title":@"Company Name",@"value":mAvailableString(dic[@"company"])},
                     @{@"title":@"Phone Number",@"value":mAvailableString(dic[@"phone"])},
                     @{@"title":@"Fax Number",@"value":mAvailableString(dic[@"fax"])},
                     @{@"title":@"Address",@"value":mAvailableString(dic[@""])},
                     @{@"title":@"Address2",@"value":mAvailableString(dic[@""])},
                     @{@"title":@"City",@"value":mAvailableString(dic[@"city"])},
                     @{@"title":@"State",@"value":mAvailableString(dic[@"state"])},
                     @{@"title":@"Country",@"value":mAvailableString(dic[@"country"])},
                     @{@"title":@"Zipcode",@"value":mAvailableString(dic[@"zipcode"])},
                     @{@"title":@"Federal Tax ID",@"value":mAvailableString(dic[@"taxID"])},
                     @{@"title":@"Sales Representative",@"value":mAvailableString(dic[@""])},
                     @{@"title":@"Office",@"value":mAvailableString(dic[@""])}];
        

    }
    
    [self.tableView reloadData];
}

#pragma mark -  UITableViewDataSource,UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = _dataAry[indexPath.row];
    
    if ([self.informationType isEqualToString:@"Account"]) {
        informationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
        cell.titleStr.text = dic[@"title"];
        cell.valueStr.text = dic[@"value"];
        cell.valueStr.userInteractionEnabled = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        InfomationTextFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:textCellName];
        cell.textFeilld.delegate = self;
        cell.textFeilld.text = (dic[@"value"] == [NSNull null] || [dic[@"value"] length] == 0 )? dic[@"title"] : dic[@"value"];
//        if (dic[@"value"] == [NSNull null] || [dic[@"value"] length] == 0 ) {
//            cell.textFeilld.textColor = UIColorFromRGB(0x9a9a9a);
//        }else{
//            cell.textFeilld.textColor = [UIColor blackColor];
//        }
        cell.textFeilld.tag = indexPath.row;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
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


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    NSDictionary *dic = _dataAry[section];
//    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//    view.backgroundColor = UIColorFromRGB(0xe9e9e9);
//
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 40)];
//    label.font = [UIFont systemFontOfSize:16];
//    label.text = [dic objectForKey:@"title"];
//
//    [view addSubview:label];
//    
//    return view;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//   
//    return 40;
//
//}

#pragma mark - UITextFiledDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    cuText = textField.text;
    textField.text = @"";
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField.text length] == 0) {
        textField.text = cuText;
    }

}

//mobile.ltsecurityinc.com/api3/customers/info?id=8127

- (void)getInformation{
    
    NSDictionary *dic = @{@"customerid":mAvailableString([HomeShareInfo sharedHomeInfoModel].userInfo.customerid)};
    
    [self.view showProgressHUDWithInfo:alert_Loading];
    [Networking GetAFNRequestWithParameters:dic andHttpType:@"customers" action:@"info" withSuccessBlock:^(id dicResult) {
        NSLog(@"请求成功:%@",dicResult);
        [self.view hiddenProgressHUD];
        NSDictionary *dic = [dicResult[@"data"] firstObject];
        [self loadDataWithDic:dic];
        
    } withErrorBlock:^(id dicResult, NSString *error) {
        [self.view hiddenProgressHUD];
        NSLog(@"请求失败:%@",dicResult);
        [self.view alertViewShowWithMessage:dicResult[@"message"] View:self.navigationController.view];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
