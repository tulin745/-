//
//  HomeMiddleCollectionViewCell.m
//  TLS
//
//  Created by 屠淋 on 15/8/10.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "HomeMiddleTableViewCell.h"
#import "HomeMenuView.h"

@interface HomeMiddleTableViewCell()

@property (nonatomic, strong) NSMutableArray *menuViews;

@end

@implementation HomeMiddleTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!_menuViews) {
            _menuViews = [NSMutableArray array];
        }
        NSArray *arr = @[@"What's new",@"Promotion"];
        for (int i = 0; i < 2; i++) {
            
            HomeMenuView *menuView = [[HomeMenuView alloc]init];
            menuView.label.text = arr[i];
//            if (i == 0) {
//                menuView.label.text = @"What's new";
//            
//            }else{
//                menuView.label.text = @"Promotion";
//            }
            [menuView.bgButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            menuView.tag = i;
            menuView.bgButton.tag = i + 10;
            [self.contentView addSubview:menuView];
            [self.menuViews addObject:menuView];
        }
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (int i = 0; i < 2; i ++) {
        HomeMenuView *menuView = self.menuViews[i];
        menuView.frame = CGRectMake(i * SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, self.height);
        if (i == 0) {
            
            [menuView.imageV sd_setImageWithURL:[NSURL URLWithString:self.imageInfo.whatsNewIcon]];
            
        }else{
            
            [menuView.imageV sd_setImageWithURL:[NSURL URLWithString:self.imageInfo.promotionIcon]];
        
        }
    }
    
    
    
}

- (void)buttonAction:(UIButton *)btn {

    for (int i = 0; i < 2; i ++) {
         HomeMenuView *menuView = self.menuViews[i];
        
        if (btn.tag - 10 == menuView.tag) {
            
            menuView.label.textColor = ThemeColor;

        }
    }
    
    if ([self.delegate respondsToSelector:@selector(HomeMiddleCell:)]) {
        [self.delegate HomeMiddleCell:btn];
    }
    

}

@end
