//
//  DropDownView.h
//  自定义下拉菜单
//
//  Created by 屠淋 on 15/9/5.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DropDownViewDelegate <NSObject>

- (void)fiterDelegate:(NSDictionary*)dic;

@end

@interface DropDownView : UIView

@property (nonatomic, assign) id<DropDownViewDelegate>delegate;

@property (nonatomic, strong) NSArray *leftArray;

@property (nonatomic, strong) NSArray *rightArray;

@property (nonatomic, copy) NSString *categoryid;

- (void)reloadSubViews;
- (void)show;
- (void)hidden;
- (void)showProgressHUD;
- (void)hiddenProgress;
@end
