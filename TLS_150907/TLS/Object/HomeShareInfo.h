//
//  HomeShareInfo.h
//  TLS
//
//  Created by 屠淋 on 15/8/19.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseClass.h"
#import "CategorieInfo.h"
#import "UserInfo.h"

@interface HomeShareInfo : NSObject

@property (nonatomic, strong) BaseClass *HomeClass;
@property (nonatomic, strong) UserInfo *userInfo;

@property (nonatomic, strong) NSMutableArray *menuArray;

+(HomeShareInfo *)sharedHomeInfoModel;

- (BOOL)isThroughAudit;//是否通过审核

@end




