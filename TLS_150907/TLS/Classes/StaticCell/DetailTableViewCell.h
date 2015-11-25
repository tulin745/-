//
//  DetailTableViewCell.h
//  TLS
//
//  Created by 屠淋 on 15/9/8.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, strong) NSArray *dataArray;

@end
