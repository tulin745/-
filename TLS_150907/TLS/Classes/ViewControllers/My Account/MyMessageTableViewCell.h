//
//  MyMessageTableViewCell.h
//  TLS
//
//  Created by newtouch on 15/8/24.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMessageTableViewCell : BaseTableViewCell
@property (strong, nonatomic) UILabel *aqiValue;
@property (strong, nonatomic) UIImageView *aqiImage;

//初始化cell类
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
-(void)setIntroductionText:(NSString*)text withColor:(UIColor*)color;
@end
