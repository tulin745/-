//
//  ToolResultCell.h
//  TLS
//
//  Created by 屠淋 on 15/8/24.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToolResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *resultTextFeild;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;

@end
