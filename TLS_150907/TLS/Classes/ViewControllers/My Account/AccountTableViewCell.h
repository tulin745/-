//
//  AccountTableViewCell.h
//  TLS
//
//  Created by newtouch on 15/8/20.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountTableViewCell : BaseTableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleStr;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *titleCenterStr;
@property (weak, nonatomic) IBOutlet UILabel *titleFirstStr;
@property (weak, nonatomic) IBOutlet UILabel *valueStr;

@end