//
//  SearchResultTableViewCell.h
//  TLS
//
//  Created by 屠淋 on 15/8/23.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImageV;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *model;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLabel;

- (void)IsNOApprovedWith:(NSDictionary*)dic;

- (void)promotionDic:(NSDictionary *)dic;
@end
