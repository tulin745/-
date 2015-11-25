//
//  SearchResultTableViewCell.m
//  TLS
//
//  Created by 屠淋 on 15/8/23.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "SearchResultTableViewCell.h"
#import "NSString+Size.h"

@implementation SearchResultTableViewCell

- (void)awakeFromNib {
    
//

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)IsNOApprovedWith:(NSDictionary *)dic{
    
    self.name.text = dic[@"productName"];
    [self.ImageV sd_setImageWithURL:[NSURL URLWithString:dic[@"smallimage"]]];
    self.model.text = [NSString stringWithFormat:@"model:%@",dic[@"model"]];
    NSString *moneyNum = [self numberFormatterWithNumber:dic[@"price"]];
    if ([dic[@"availability"] integerValue] == 1) {
        self.status.text = @"In Stock";
    }else{
        self.status.text = @"Out Stock";
    }
    
    if ([[HomeShareInfo sharedHomeInfoModel] isThroughAudit]) {
        self.money.text = [NSString stringWithFormat:@"$ %@",moneyNum];

    }else{
        self.money.font = [UIFont systemFontOfSize:15];
        self.money.text = @"Sign In For Price";
        self.money.textColor = [UIColor whiteColor];
        self.money.backgroundColor = [UIColor lightGrayColor];
        self.money.textAlignment = NSTextAlignmentCenter;
        
    }
    
    CGSize labelSize = [self.money.text getTextSizeWithString:self.money.text font:self.money.font Height:self.money.height];
    
    self.constraintLabel.constant = labelSize.width + 20;

}

- (void)promotionDic:(NSDictionary *)dic{
    
    self.name.text = dic[@"name"];
    self.model.text = dic[@"model"];
    [self.ImageV sd_setImageWithURL:[NSURL URLWithString:dic[@"smallimage"]]];


    if ([dic[@"availability"] integerValue] == 1) {
        self.status.text = @"In Stock";
    }else{
        self.status.text = @"Out Stock";
    }
    
    NSString *moneyNum = [self numberFormatterWithNumber:dic[@"special_price"]];

    if ([[HomeShareInfo sharedHomeInfoModel] isThroughAudit]) {
        self.money.text = [NSString stringWithFormat:@"$ %@",moneyNum];
        
    }else{
        self.money.font = [UIFont systemFontOfSize:15];
        self.money.text = @"Sign In For Price";
        self.money.textColor = [UIColor whiteColor];
        self.money.backgroundColor = [UIColor lightGrayColor];
        
    }
    
}


- (NSString *)numberFormatterWithNumber:(NSString *)number
{
    CGFloat num = [number doubleValue];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [formatter stringFromNumber:[NSNumber numberWithDouble:num]];

    return formattedNumberString;
}

@end
