//
//  SettingTableViewCell.h
//  TLS
//
//  Created by newtouch on 15/9/3.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewCell : BaseTableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleStr;
@property (weak, nonatomic) IBOutlet UILabel *titleCenterStr;

@end
