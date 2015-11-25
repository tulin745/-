//
//  TAlertView.m
//  TLS
//
//  Created by 屠淋 on 15/8/8.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "TAlertView.h"
#import "NSString+Size.h"
@interface TAlertView()
{
    NSString *_title;
    NSString *_message;
    NSArray  *_buttons;
}

@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) NSMutableArray *btnArr;
@end

@implementation TAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBACOLOR(0, 0, 0, 0.3);
        
    }
    return self;
}

- (NSMutableArray *)btnArr{
    
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
   return _btnArr;
}
- (void)initAlertWithTitle:(NSString*)title message:(NSString *)message andButtons:(NSArray*)buttons{
    
    //alertView
    UIView *alertView = [[UIView alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT / 2 - 80, SCREEN_WIDTH - 60, 150)];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 8;
    alertView.clipsToBounds = YES;
    [self addSubview:alertView];
    self.alertView = alertView;
    //title
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, alertView.width, 30)];
    
    titleLabel.text = title;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [alertView addSubview:titleLabel];
    
    //message
    UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, alertView.width - 15, 60)];
    
    messageLabel.text = message;
    messageLabel.numberOfLines = 0;
    messageLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = UIColorFromRGB(0x393939);
    messageLabel.textAlignment = NSTextAlignmentCenter;
    
    [alertView addSubview:messageLabel];
    
    self.messageLabel = messageLabel;
    
    for (int i = 0; i < buttons.count ; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        button.frame = CGRectMake(i * SCREEN_WIDTH / buttons.count - 2, alertView.height - 40 , alertView.width / buttons.count + 4, 42);
        button.layer.borderColor = UIColorFromRGB(0xe9e9e9).CGColor;
        button.layer.borderWidth = 1;
        [button setTitleColor:UIColorFromRGB(0x1195e7) forState:UIControlStateNormal];
        [button setTitle:buttons[i] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [alertView addSubview:button];
        [self.btnArr addObject:button];
    }

}

- (void)btnAction:(UIButton*)btn{
    
    if ([self.delegate respondsToSelector:@selector(TalertView:clickedButtonAtIndex:)]) {
        [self.delegate TalertView:self clickedButtonAtIndex:btn.tag];
    }
    
    [self removeFromSuperview];
    

}

- (void)layoutSubviews{
    [super layoutSubviews];
    
   CGSize size = [self.messageLabel.text getTextSizeWithString:self.messageLabel.text font:[UIFont systemFontOfSize:14] width:self.alertView.width - 15];
    self.messageLabel.size = size;
    self.alertView.height = size.height + 90;
    for (int i = 0; i < self.btnArr.count ; i++) {
        UIButton *button = self.btnArr[i];
        button.frame = CGRectMake(i * SCREEN_WIDTH / self.btnArr.count - 2, self.alertView.height - 40 , self.alertView.width / self.btnArr.count + 4, 42);

    }
    
 }

- (void)showOnView:(UIView*)superView{
    
//    UIWindow* appWindow = [UIApplication sharedApplication].keyWindow;

    [superView addSubview:self];

}





@end
