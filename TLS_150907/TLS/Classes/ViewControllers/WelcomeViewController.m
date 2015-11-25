//
//  WelcomeViewController.m
//  TLS
//
//  Created by 屠淋 on 15/8/7.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LoginViewController.h"
#import "SignUpViewController.h"

@interface WelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *logInButton;

@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@end

@implementation WelcomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.logInButton.layer.borderColor = UIColorFromRGB(0xD3D3D3).CGColor;
    self.logInButton.layer.borderWidth = 0.5;

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logInAction:(UIButton *)sender {//登录
    
    LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    
    [self.navigationController pushViewController:loginVC animated:YES];
    
}

- (IBAction)SignUpAction:(UIButton *)sender {//注册
    
    SignUpViewController *signUpVC = [[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
    [self.navigationController pushViewController:signUpVC animated:YES];
}

- (IBAction)Skip:(UIButton *)sender {
    if (self.block) {
        self.block();
    }
}



@end
