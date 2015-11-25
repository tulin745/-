//
//  ModifyPasswordViewController.m
//  TLS
//
//  Created by newtouch on 15/8/16.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import "InputTableViewCell.h"
#import "LoginViewController.h"


@interface ModifyPasswordViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>{
    NSArray *titleArray;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *submit;
@property (strong, nonatomic) NSMutableDictionary *dicData;

@end

@implementation ModifyPasswordViewController
- (NSMutableDictionary*)dicData{
    
    if (!_dicData) {
        _dicData = [NSMutableDictionary dictionary];
    }
    return _dicData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Modify Password";
    titleArray = @[@"Old password",@"New Password",@"Confirm Password"];
    [_submit setTitle:@"Submit" forState:UIControlStateNormal];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InputTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InputTableViewCell"];
    if (!cell) {
        cell = NIB_Load(@"InputTableViewCell");
    }
    cell.titleLabel.text = titleArray[indexPath.row];
    cell.textFeild.delegate = self;
    cell.textFeild.tag = indexPath.row;
    cell.IsPassword = YES;
    [self.dicData setObject:cell forKey:indexPath];
    return cell;
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 0:{
            
            break;
        }
        case 1:{
            
            break;
        }
        case 2:{
            InputTableViewCell *NewPassword = (InputTableViewCell*)[self.dicData objectForKey:[NSIndexPath indexPathForRow:1 inSection:0]];
            if (![textField.text isEqualToString:NewPassword.textFeild.text]) {
                [self.view showMessageHUD:@"两次输入密码不一致" timeout:1.5];
                NSLog(@"两次输入密码位数一致");
            }
            break;
        }
        default:
            break;
    }
}

- (IBAction)modifyPassword:(id)sender {
    [self.view showProgressHUDWithInfo:@"Waiting..."];

    InputTableViewCell *OldPassword = (InputTableViewCell*)[self.dicData objectForKey:[NSIndexPath indexPathForRow:0 inSection:0]];
    InputTableViewCell *NewPassword = (InputTableViewCell*)[self.dicData objectForKey:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    
    if ([[HomeShareInfo sharedHomeInfoModel].userInfo.customerid length] != 0) {//是否登录 获取过customerid
        NSDictionary *requestDic = @{@"action":@"updatepwd",
                                     @"id":mAvailableString([HomeShareInfo sharedHomeInfoModel].userInfo.customerid),//接口变动  entity_id 变为 customerid
                                     @"oldpassword":OldPassword.textFeild.text,
                                     @"newpassword":NewPassword.textFeild.text};
        NSLog(@"requestDic:%@",requestDic);
       [Networking GetAFNRequestWithParameters:requestDic andHttpType:HttpType_customers action:@"updatepwd" withSuccessBlock:^(id dicResult) {
           
           NSMutableDictionary *dic = [[[JXUserDefault objectValueForKey:UserDefault_userInfo][@"data"] firstObject] mutableCopy];
           NSArray *keys = [dic allKeys];
           for (NSString *key in keys) {//清空所有数据
               [dic setValue:@"0" forKey:key];
           }
           [JXUserDefault setObjectValue:dic forKey:UserDefault_userInfo];
           
           [self.view hiddenProgressHUD];
           NSLog(@"request:%@",dicResult);
           UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Prompt" message:@"Password is changed, please log in again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
           [alertView show];
//           [self.view showProgressHUDWithInfo:@"Exit waiting..."];
       } withErrorBlock:^(id dicResult, NSString *error) {
           NSLog(@"request:%@",dicResult);
           [self.view hiddenProgressHUD];
           [self.view alertViewShowWithMessage:dicResult[@"message"] View:self.navigationController.view];
       }];
    }
       
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    loginVC.fromPlace = @"Modify";
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.navigationController pushViewController:loginVC animated:YES];

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
