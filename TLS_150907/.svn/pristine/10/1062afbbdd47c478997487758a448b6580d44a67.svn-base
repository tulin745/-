//
//  MyCartTableViewCell.m
//  TLS
//
//  Created by 屠淋 on 15/8/22.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "MyCartTableViewCell.h"

@implementation MyCartTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectButtonAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedGOODs:andIndexPath:)]) {
        [self.delegate selectedGOODs:sender andIndexPath:self.indexPath];
    }
    
}

- (IBAction)bashAction:(UIButton *)sender {
    
    int number = [self.numberLabel.text intValue];
    if (number > 1) {
        self.numberLabel.text = [NSString stringWithFormat:@"%d",--number];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateItemWithStr:andIndexPath:)]) {
        [self.delegate updateItemWithStr:self.numberLabel.text andIndexPath:self.indexPath];
    }
}

- (IBAction)plusAction:(UIButton *)sender {
    
    int number = [self.numberLabel.text intValue];
    if (number < 100) {
        self.numberLabel.text = [NSString stringWithFormat:@"%d",++number];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateItemWithStr:andIndexPath:)]) {
        [self.delegate updateItemWithStr:self.numberLabel.text andIndexPath:self.indexPath];
    }
}

- (void)getContentWithDic:(NSDictionary *)dic{
    
    self.numberLabel.text = [NSString stringWithFormat:@"%@",dic[@"product_qty"]];
    self.nameLabel.text = dic[@"product_name"];
    NSString *moneyNum = [self numberFormatterWithNumber:dic[@"product_price"]];
    self.moneyLabel.text = [NSString stringWithFormat:@"$ %@",moneyNum];
    [self.ImageV sd_setImageWithURL:dic[@"product_image"]];
    self.modelLabel.text = [NSString stringWithFormat:@"Model:%@",dic[@"product_model"]];

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
