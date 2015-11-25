//
//  ToolTextFCell.m
//  TLS
//
//  Created by 屠淋 on 15/8/24.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "ToolTextFCell.h"

@interface  ToolTextFCell()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation ToolTextFCell

- (UIPickerView *)pickerView{
    
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 162)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (void)awakeFromNib {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.width.constant = SCREEN_WIDTH / 2.2;

}

- (void)layoutSubviews{
    
    [super layoutSubviews];

    if (self.pickerDataArray.count != 0) {
        self.textFeild.inputView  = self.pickerView;
    }
    
}


#pragma mark - UIPickerViewDataSource,UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.pickerDataArray.count;

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.pickerDataArray[row];

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.textFeild.text = self.pickerDataArray[row];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
