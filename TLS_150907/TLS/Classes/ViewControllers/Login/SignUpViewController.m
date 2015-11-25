//
//  SignUpViewController.m
//  TLS
//
//  Created by 屠淋 on 15/8/8.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "SignUpViewController.h"
#import "PhoneNumberCell.h"
#import "InputTableViewCell.h"
#import "TAlertView.h"
#import "TextFieldWithIndexPath.h"

@interface SignUpViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,TAlertViewDelegate>
{
    NSArray *titleArray;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *dicData;

@end

@implementation SignUpViewController

- (NSMutableDictionary*)dicData{
    
    if (!_dicData) {
        _dicData = [NSMutableDictionary dictionary];
    }
    return _dicData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Sign Up";
    
    titleArray = @[@[@"User Information",@[@"First Name",@"Last Name",@"Email",@"Phone Number"]],
                   @[@"Login Information",@[@"Password",@"Confirm Password"]]];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"Cancel" target:self action:@selector(cancelSign)];
    
    [self.tableView setTableViewExtraFooterView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return titleArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = titleArray[section][1];
    return arr.count;
    
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *arr = titleArray[indexPath.section][1];
    
//    if (indexPath.section == 0 && indexPath.row == 3) {
//        
//        PhoneNumberCell * phoneNcell = [tableView dequeueReusableCellWithIdentifier:@"PhoneNumberCell"];
//        if (!phoneNcell) {
//            phoneNcell = NIB_Load(@"PhoneNumberCell");
//        }
//        phoneNcell.titleLabel.text = arr[indexPath.row];
//
//        [phoneNcell.getVerCodeBtn addTarget:self action:@selector(getVerCode) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self.dicData setObject:phoneNcell forKey:indexPath];
//        
//        return phoneNcell;
//    }
    
    InputTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InputTableViewCell"];
    if (!cell) {
        cell = NIB_Load(@"InputTableViewCell");
    }
    cell.titleLabel.text = arr[indexPath.row];

    if (indexPath.section == 1) {
        cell.IsPassword = YES;

    }else{
        cell.IsPassword = NO;
    }
    
    [self.dicData setObject:cell forKey:indexPath];
    
    return cell;
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44.0;

}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    NSString *string = titleArray[section][0];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    headerView.backgroundColor = UIColorFromRGB(0xe9e9e9);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 44)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = string;
    [headerView addSubview:label];
    
    return headerView;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
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



#pragma mark - getVerCode

- (void)getVerCode{//获取验证码
    
    
    
}

- (void)cancelSign{
    
    [self.navigationController popViewControllerAnimated:YES];


}

- (IBAction)signUpAction:(UIButton *)sender {
   
    if ([self checkData]) {
        
        [self signUpRequest];

    }
}

- (void)alertViewShow{
    
    NSString *message = @"Approval process may take a few days,please contact your sales representative to expedite your request";
    TAlertView *alertV = [[TAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    alertV.delegate = self;
    [alertV initAlertWithTitle:@"Thanks for Signing Up!" message:message andButtons:@[@"OK"]];
    [alertV showOnView:self.navigationController.view];
    
}

#pragma mark - TAlertViewDelegate

- (void)TalertView:(TAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{

    
    

}

#pragma mark - 校验
- (BOOL)checkData{
    
//    PhoneNumberCell *cellPhone = (PhoneNumberCell *)[self.dicData objectForKey:[NSIndexPath indexPathForRow:3 inSection:0]];
    
        InputTableViewCell *cellPhone = (InputTableViewCell*)[self.dicData objectForKey:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    InputTableViewCell *cellFirName = (InputTableViewCell*)[self.dicData objectForKey:[NSIndexPath indexPathForRow:0 inSection:0]];
    InputTableViewCell *cellLastName = (InputTableViewCell*)[self.dicData objectForKey:[NSIndexPath indexPathForRow:1 inSection:0]];
    InputTableViewCell *cellEmail = (InputTableViewCell*)[self.dicData objectForKey:[NSIndexPath indexPathForRow:2 inSection:0]];
    InputTableViewCell *cellPassword = (InputTableViewCell*)[self.dicData objectForKey:[NSIndexPath indexPathForRow:0 inSection:1]];
    InputTableViewCell *cellConfPassword = (InputTableViewCell*)[self.dicData objectForKey:[NSIndexPath indexPathForRow:1 inSection:1]];
    
    if ([cellFirName.textFeild.text length] == 0) {
        [self.view alertViewShowWithMessage:signUp_firstNameEm View:self.navigationController.view];
        return NO;
    }else if ([cellLastName.textFeild.text length] == 0) {
        [self.view alertViewShowWithMessage:signUp_lastNameEM View:self.navigationController.view];
        return NO;
    }else if ([cellEmail.textFeild.text length] == 0) {
        [self.view alertViewShowWithMessage:signUp_emailEM View:self.navigationController.view];
        return NO;
    }else if ([cellPhone.textFeild.text length] == 0) {
        [self.view alertViewShowWithMessage:signUp_phoneEM View:self.navigationController.view];
        return NO;
    }
    else if ([cellPassword.textFeild.text length] == 0) {
        [self.view alertViewShowWithMessage:signUp_passwordEM View:self.navigationController.view];
        return NO;
    }else if ([cellConfPassword.textFeild.text length] == 0) {
        [self.view alertViewShowWithMessage:signUp_ConfirmPasswordEM View:self.navigationController.view];
        return NO;
    }else if (![cellConfPassword.textFeild.text isEqualToString:cellPassword.textFeild.text]){
        [self.view alertViewShowWithMessage:signUp_PasswordNotSame View:self.navigationController.view];
        return NO;
    }
    return YES;
    

}

- (void)signUpRequest{
    
    //www.ltsecurityinc.com/api3/customers?action=register&amp;email=joeleanli@hotmail.com&firstname=li&lastname=joelean&phone=5105678419&password=123456
    
    InputTableViewCell *cellPhone = (InputTableViewCell *)[self.dicData objectForKey:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    InputTableViewCell *cellFirName = (InputTableViewCell*)[self.dicData objectForKey:[NSIndexPath indexPathForRow:0 inSection:0]];
    InputTableViewCell *cellLastName = (InputTableViewCell*)[self.dicData objectForKey:[NSIndexPath indexPathForRow:1 inSection:0]];
    InputTableViewCell *cellEmail = (InputTableViewCell*)[self.dicData objectForKey:[NSIndexPath indexPathForRow:2 inSection:0]];
    InputTableViewCell *cellPassword = (InputTableViewCell*)[self.dicData objectForKey:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    NSDictionary *dic = @{@"phone":mAvailableString(cellPhone.textFeild.text),
                          @"email":mAvailableString(cellEmail.textFeild.text),
                          @"firstname":mAvailableString(cellFirName.textFeild.text),
                          @"lastname":mAvailableString(cellLastName.textFeild.text),
                          @"password":mAvailableString(cellPassword.textFeild.text)
                          };
    
    [self.view showProgressHUDWithInfo:alert_Loading];

//    [Networking GetAFNRequestWithParameters:dic andHttpType:@"customers" withSuccessBlock:^(id dicResult) {
//        [self.view hiddenProgressHUD];
//        NSLog(@"请求成功:%@",dicResult);
//        [self alertViewShow];
//
//    } withErrorBlock:^(id dicResult, NSString *error) {
//        
//        [self.view hiddenProgressHUD];
//        NSLog(@"请求失败:%@",dicResult);
//        [self.view alertViewShowWithMessage:dicResult[@"message"]];
//
//    }];
    
    [Networking GetAFNRequestWithParameters:dic andHttpType:HttpType_customers action:@"register" withSuccessBlock:^(id dicResult) {
        [self.view hiddenProgressHUD];
        NSLog(@"请求成功:%@",dicResult);
        [self alertViewShow];
        
    } withErrorBlock:^(id dicResult, NSString *error) {
        [self.view hiddenProgressHUD];
        NSLog(@"请求失败:%@",dicResult);
        [self.view alertViewShowWithMessage:dicResult[@"message"] View:self.navigationController.view];
    }];
    
}

@end
