//  ShopCartView.m
//  TLS
//
//  Created by 屠淋 on 15/8/20.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "ShopCartView.h"

@implementation ShopCartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self requetCartNum];
        
        self.labelAngle = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width - 14, 5, 12, 12)];
        self.labelAngle.backgroundColor = ThemeColor;
        self.labelAngle.textColor = [UIColor whiteColor];
        self.labelAngle.textAlignment = NSTextAlignmentCenter;
        self.labelAngle.layer.cornerRadius = 6;
        self.labelAngle.layer.masksToBounds = YES;
        self.labelAngle.font = [UIFont systemFontOfSize:8];
        
        [self addSubview:self.labelAngle];
        
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(15,12 , 20, 20)];
        self.imageV.image = [UIImage imageNamed:@"shopping-mart"] ;
        [self addSubview:self.imageV];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = frame;
        [self addSubview:self.button];        
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    if ([self.cartNum integerValue]> 0) {
        self.labelAngle.hidden = NO;
        self.labelAngle.text = self.cartNum;
    }else{
        self.labelAngle.hidden = YES;
    }
    
}

- (void)requetCartNum{
    
        //    mobile.ltsecurityinc.com/api3/carts/addItem?productid=218
        
        NSDictionary *dic = @{@"customerid":mAvailableString([HomeShareInfo sharedHomeInfoModel].userInfo.customerid)};
        
        [Networking GetAFNRequestWithParameters:dic andHttpType:@"carts" action:@"getItemsCount" withSuccessBlock:^(id dicResult) {
            NSLog(@"请求成功:%@",dicResult);

            NSString *data = (dicResult[@"data"] == [NSNull null] ? @"" : dicResult[@"data"]);

            [JXUserDefault setObjectValue:mAvailableString(data) forKey:cartList];
          
            self.cartNum = [NSString stringWithFormat:@"%@",mAvailableString(dicResult[@"data"])];
            [self setNeedsLayout];
            
        } withErrorBlock:^(id dicResult, NSString *error) {
            NSLog(@"请求失败:%@",dicResult);
            
        }];
        
    
}

@end
