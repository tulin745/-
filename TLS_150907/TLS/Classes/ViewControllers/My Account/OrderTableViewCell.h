//
//  OrderTableViewCell.h
//  TLS
//
//  Created by newtouch on 15/8/24.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : BaseTableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *commodityImage;
@property (strong, nonatomic) IBOutlet UILabel *commodityName;
@property (strong, nonatomic) IBOutlet UILabel *commodityModel;
@property (strong, nonatomic) IBOutlet UILabel *commodityPrice;
@property (strong, nonatomic) IBOutlet UILabel *commoditCount;

@end
