//
//  DetailTableViewCell.m
//  TLS
//
//  Created by 屠淋 on 15/9/8.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "DetailTableViewCell.h"

@interface DetailTableViewCell()
{
    NSArray *titlesArray;

}
@property (nonatomic, strong) UIView *underLineView;

@property (nonatomic, strong) NSMutableArray *arrayButton;

@end

@implementation DetailTableViewCell

- (NSMutableArray*)arrayButton{
    
    if (!_arrayButton) {
        _arrayButton = [NSMutableArray array];
    }
    return _arrayButton;
}

- (void)awakeFromNib {
    titlesArray = @[@"DETAILS",@"SPECIFICATION",@"DOWNLOADS"];
    [self creatButtonTabBarTexts:titlesArray];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}


- (void)creatButtonTabBarTexts:(NSArray* )texts{
    
    titlesArray = texts;

    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0;  i < texts.count ; i++) {
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:texts[i] forState:UIControlStateNormal];

        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        if (i == 0) {
            [button setTitleColor:UIColorFromRGB(0xe60012) forState:UIControlStateNormal];

        }
        
        if (SCREEN_WIDTH == 320) {
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        }else{
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        }
        
        button.frame = CGRectMake(i * SCREEN_WIDTH / texts.count, 0, SCREEN_WIDTH / texts.count, 40);
        button.tag = i;
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [self.arrayButton addObject:button];
    }
    
    UIView* lView = [[UIView alloc]initWithFrame:CGRectMake(0, view.height - 2, SCREEN_WIDTH, 2)];
    lView.backgroundColor = Color_RGB(180, 180, 180);
    [view addSubview:lView];
    
    _underLineView = [[UIView alloc]initWithFrame:CGRectMake(0, view.height - 2, SCREEN_WIDTH / texts.count, 2)];
    _underLineView.backgroundColor = UIColorFromRGB(0xe60012);
    [view addSubview:_underLineView];
    
    [self.headView addSubview:view];
    
}


- (void)titleButtonClick:(UIButton*)btn{
    
    for (UIButton *button in self.arrayButton) {
        if (button.tag == btn.tag) {
            [button setTitleColor:UIColorFromRGB(0xe60012) forState:UIControlStateNormal];
        }else{
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _underLineView.frame = CGRectMake(btn.tag * SCREEN_WIDTH / titlesArray.count, _underLineView.y, _underLineView.width, _underLineView.height);
    }];
    
    NSString *dataHTML = self.dataArray[btn.tag];
    [self.webView loadHTMLString:dataHTML baseURL:nil];

}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.webView loadHTMLString:mAvailableString(self.dataArray[0]) baseURL:nil];

}

@end
