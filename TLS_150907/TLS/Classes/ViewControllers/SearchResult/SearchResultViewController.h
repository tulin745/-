//
//  SearchResultViewController.h
//  TLS
//
//  Created by 屠淋 on 15/8/23.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchResultViewController : BaseViewController

@property (nonatomic, copy) NSString *ID;//产品ID

@property (nonatomic, strong) NSArray *promotionArray;
@property (nonatomic, copy) NSString *searchValue;
@end
