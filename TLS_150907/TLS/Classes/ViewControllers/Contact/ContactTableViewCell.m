//
//  ContactTableViewCell.m
//  TLS
//
//  Created by newtouch on 15/8/21.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "ContactTableViewCell.h"
@interface ContactTableViewCell ()<UIAlertViewDelegate>

@property (nonatomic, strong) UIWebView *callWebview;

@property (nonatomic, strong) UILabel *label;

@end

@implementation ContactTableViewCell
- (IBAction)callTell:(UIButton *)sender {

    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.titleStr.text];

    [_callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    
}



- (void)awakeFromNib {

    UIWebView * callWebview = [[UIWebView alloc] init];
    _callWebview = callWebview;
    [self.contentView addSubview:_callWebview];

//    UILabel *label = [[UILabel alloc]init];
//    label.text = @"------------------------------------------------------------------";
//    label.textColor = [UIColor lightGrayColor];
//    [self addSubview:label];
//    self.label = label;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    self.label.hidden = self.hiddenLabel;
//    self.label.frame = CGRectMake(0, 43, SCREEN_WIDTH - 35, 2);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
