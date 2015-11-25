//
//  SearchHeadView.m
//  TLS
//
//  Created by 屠淋 on 15/8/23.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "SearchHeadView.h"
#import "RightImageButton.h"

@interface SearchHeadView()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSArray *dataArray;


@end

@implementation SearchHeadView


- (NSMutableArray*)buttons{
    
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }

    return _buttons;
}



- (void)initWithArray:(NSArray*)array andFrame:(CGRect)frame{
    
    self.frame = frame;
    self.dataArray = array;
    
    for (int i = 0; i < [array count]; i ++) {
        RightImageButton *button = nil;
        
        if (i == 1 || i == 2) {
            button = [[RightImageButton alloc]init];
            [button setImage:[UIImage imageNamed:@"price-up"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"price-down"] forState:UIControlStateSelected];
        }else{
            button = (RightImageButton *)[UIButton buttonWithType:UIButtonTypeCustom];
        }
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.buttons addObject:button];
    }
    
  
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / array.count * 3, 5, 1, 30)];
    lineView.backgroundColor = UIColorFromRGB(0xc8c8c8);
    [self addSubview:lineView];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 1)];
    footView.backgroundColor = UIColorFromRGB(0xc8c8c8);
    [self addSubview:footView];


}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    for (int i = 0; i < self.dataArray.count; i ++) {
        
        UIButton * button = self.buttons[i];
        [button setTitle:self.dataArray[i] forState:UIControlStateNormal];
        if (i == 3) {
            [button setTitle:@"Shop Options" forState:UIControlStateSelected];
        }
        button.frame = CGRectMake(i * SCREEN_WIDTH / self.dataArray.count, 0, SCREEN_WIDTH / self.dataArray.count, self.height);
        
        
    }
    
    
}

- (void)buttonAction:(UIButton *)button{
    
//    if ([button.titleLabel.text isEqualToString:@"Shop By"]) {
//    }else if([button.titleLabel.text isEqualToString:@"Shop Options"]){
//        [button setTitle:@"Shop By" forState:UIControlStateNormal];
//    }
    button.selected = !button.selected;
    if ([self.delegate respondsToSelector:@selector(headButtonAction:)]) {
        [self.delegate headButtonAction:button];
    }

}

@end
