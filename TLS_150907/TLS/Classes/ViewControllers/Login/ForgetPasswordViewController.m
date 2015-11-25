//
//  ForgetPasswordViewController.m
//  TLS
//
//  Created by 屠淋 on 15/8/8.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "PhoneNumberCell.h"
#import "InputTableViewCell.h"

@interface ForgetPasswordViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *titleArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Retrieve Password";
    titleArray = @[@"",@"Captchas",@"New Password",@"Confirm Password"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;

}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        PhoneNumberCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PhoneNumberCell"];
        if (!cell) {
            cell = NIB_Load(@"PhoneNumberCell");
        }
        [cell.getVerCodeBtn addTarget:self action:@selector(getVerCode) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        
        InputTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InputTableViewCell"];
        if (!cell) {
            cell = NIB_Load(@"InputTableViewCell");
        }
        cell.titleLabel.text = titleArray[indexPath.row];
        
        if (indexPath.row != 1) {
            cell.IsPassword = YES;
        }
        
        return cell;
    
    }
   

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

- (IBAction)doneAction:(UIButton *)sender {
    
    
}

@end
