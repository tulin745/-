//
//  informationTableViewCell.h
//  TLS
//
//  Created by newtouch on 15/8/17.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface informationTableViewCell : BaseTableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleStr;
@property (strong, nonatomic) IBOutlet UITextField *valueStr;

@end
