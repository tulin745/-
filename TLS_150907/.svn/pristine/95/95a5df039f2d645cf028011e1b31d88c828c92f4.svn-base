//
//  HomeFooterCollectionViewCell.m
//  TLS
//
//  Created by 屠淋 on 15/8/10.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "HomeFooterTableViewCell.h"

@interface HomeFooterTableViewCell()

@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, strong) NSMutableArray *titleLabels;
@property (nonatomic, strong) NSMutableArray *middleLabels;
@property (nonatomic, strong) NSMutableArray *footBtns;

@property (nonatomic, strong) NSMutableArray *pointViews;
;
@property (nonatomic, strong) UIView *linView;

@end

@implementation HomeFooterTableViewCell

- (NSMutableArray *)buttons{
    
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }

    return _buttons;
}
- (NSMutableArray *)footBtns{
    
    if (!_footBtns) {
        _footBtns = [NSMutableArray array];
    }
    
    return _footBtns;
}
- (NSMutableArray *)titleLabels{
    
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    
    return _titleLabels;
}

- (NSMutableArray *)pointViews{
    
    if (!_pointViews) {
        _pointViews = [NSMutableArray array];
    }
    
    return _pointViews;
}
- (NSMutableArray *)middleLabels{
    
    if (!_middleLabels) {
        _middleLabels = [NSMutableArray array];
    }
    
    return _middleLabels;
}

- (void)awakeFromNib{
    [super awakeFromNib];

    NSArray *array = @[@[@"pdf-ip",@"IP Solutions",@"",@"Download"],
                       @[@"pdf-hd",@"HD TVI Solutions",@"",@"Download"]];
    
    for (int i = 0; i < 2; i ++) {
        NSArray *contentArray = array[i];
       
        //图片
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:contentArray[0]] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        button.tag = i + 100;
        [self.buttons addObject:button];
        [self.contentView addSubview:button];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = contentArray[1];
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        [self.titleLabels addObject:titleLabel];
        [self.contentView addSubview:titleLabel];
        
        UILabel *middleLabel = [[UILabel alloc]init];
        middleLabel.text = contentArray[2];
        middleLabel.font = [UIFont systemFontOfSize:14];
        middleLabel.textColor = UIColorFromRGB(0x999999);
        
        [self.middleLabels addObject:middleLabel];
        [self.contentView addSubview:middleLabel];
        
        UIView *pointView = [[UIView alloc]init];
        pointView.layer.cornerRadius = 4;
        pointView.layer.masksToBounds = YES;
        pointView.hidden = YES;
        pointView.backgroundColor = ThemeColor;
        [self.contentView addSubview:pointView];
        [self.pointViews addObject:pointView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 1000+i;
   
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        [self.footBtns addObject:btn];
        
    }
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = UIColorFromRGB(0xe9e9e9);
    [self.contentView addSubview:lineView];
    self.linView = lineView;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSArray *oldVersons = [JXUserDefault objectValueForKey:@"version"];
    
    for (int i = 0; i < 2; i ++) {
        NSString *oldVersion = @"";
        if ([oldVersons count] != 0) {
           oldVersion = [oldVersons objectAtIndex:i];
        }
        
        //图片
        UIButton *button = self.buttons[i];
        
        if (SCREEN_WIDTH == 320) {
            button.frame = CGRectMake(i * SCREEN_WIDTH / 2 + 10 , self.height / 4 , SCREEN_WIDTH / 6 , self.height / 2 );
        }else{
            button.frame = CGRectMake(i * SCREEN_WIDTH / 2 + 20 , self.height / 4 , SCREEN_WIDTH / 6 , self.height / 2);
        }
        
        UILabel *titleLabel = self.titleLabels[i];
        titleLabel.frame = CGRectMake(CGRectGetMaxX(button.frame) + 5, button.y + 12, 100, 20);
        
        UILabel *middleLabel = self.middleLabels[i];
        middleLabel.frame = CGRectMake(CGRectGetMaxX(button.frame) + 5, button.y + 42, 100, 18);
      
        NSString *newVersion = self.version.count != 0 ? [self.version objectAtIndex:i] : @"";
        middleLabel.text = newVersion;
        
        UIView *pointV = self.pointViews[i];
        pointV.frame = CGRectMake(button.right - 4, button.y - 3, 8, 8);
        
        if ([oldVersion length] != 0 && [newVersion length] != 0) {
           
            if ([oldVersion isEqualToString:newVersion]) {
                pointV.hidden = YES;
            } else{
                pointV.hidden = NO;
            }
        }
        
        UIButton *footButton = self.footBtns[i];
        footButton.frame = CGRectMake(self.width/2 * i, 0,self.width / 2 , self.height);
    }
    
    self.linView.frame = CGRectMake(SCREEN_WIDTH / 2 - 1, 20, 1, self.height - 40);
    
    if ([self.version count] != 0) {
        [JXUserDefault setObjectValue:self.version forKey:@"version"];
    }
    

}

- (void)buttonClick:(UIButton *)button {
    
    if([self.delegate respondsToSelector:@selector(openFileAction:)]){
        [self.delegate openFileAction:button];
    }

}



@end
