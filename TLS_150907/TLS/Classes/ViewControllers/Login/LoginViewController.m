//
//  LoginViewController.m
//  TLS
//
//  Created by 屠淋 on 15/8/8.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetPasswordViewController.h"
#import "SignUpViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *customTextF;
@property (weak, nonatomic) IBOutlet UITextField *passwTextF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"Sign Up" target:self action:@selector(SignUp)];
    if ([_fromPlace isEqualToString:@"Logout"]||[_fromPlace isEqualToString:@"Modifyl"]) {
        [self.navigationItem.leftBarButtonItem setEnabled:NO];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//忘记密码
- (IBAction)forgetPasswordAction:(UIButton *)sender {
    ForgetPasswordViewController *forgetVC = [[ForgetPasswordViewController alloc]initWithNibName:@"ForgetPasswordViewController" bundle:nil];
    
    [self.navigationController pushViewController:forgetVC animated:YES];
}

//登录
- (IBAction)signInAction:(UIButton *)sender {
    
    if ([self.customTextF.text length] == 0) {
        [self.view alertViewShowWithMessage:login_accountEmpty View:self.navigationController.view];
        return;
    }else if ([self.passwTextF.text length] == 0)
    {
        [self.view alertViewShowWithMessage:login_passwordEmpty View:self.navigationController.view];
        return;
    }
    [self loginRequest];
    
}

- (void)SignUp{//注册
    
    SignUpViewController *signVc = [[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
    
    [self.navigationController pushViewController:signVc animated:YES];

}


- (void)loginRequest{
    
    [self.view showProgressHUDWithInfo:alert_Login];
    
//NSString *keyMailPhone = @"";
//    if ([self validateEmail:self.customTextF.text]) {
//       keyMailPhone = @"email";
//    }else{
//        keyMailPhone = @"phone";
//    }
    
    NSDictionary *dic = @{@"action":@"login",
                          @"email":self.customTextF.text,
                          @"password":self.passwTextF.text};
    [Networking GetAFNRequestWithParameters:dic andHttpType:HttpType_customers action:@"login" withSuccessBlock:^(id dicResult) {
        
        NSLog(@"请求成功:%@",dicResult);
        [self.view hiddenProgressHUD];
        
        [JXUserDefault setObjectValue:dicResult forKey:UserDefault_userInfo];

        if ([self.fromPlace isEqualToString:@"AppDelegate"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"Login" object:nil userInfo:nil];

        }
        
    } withErrorBlock:^(id dicResult, NSString *error) {
        NSLog(@"请求失败:%@",dicResult);
        [self.view alertViewShowWithMessage:dicResult[@"message"] View:self.navigationController.view];
        [self.view hiddenProgressHUD];
    }];

}

- (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
