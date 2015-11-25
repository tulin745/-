//
//  NewMenuViewController.h
//  TLS
//
//  Created by 屠淋 on 15/9/7.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "BaseViewController.h"

@class NewMenuViewController;

@protocol NewMenuViewControllerDelegate <NSObject>

- (void)menuVC:(NewMenuViewController *)vc andInfo:(CategorieInfo*)info;

@end

@interface NewMenuViewController : BaseViewController

@property (nonatomic, assign) id<NewMenuViewControllerDelegate>delegate;

//+ (MenuViewController *)sharedMenuVC;


- (void)show;

- (void)hidden;

@end
