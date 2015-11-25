//
//  HomeShareInfo.m
//  TLS
//
//  Created by 屠淋 on 15/8/19.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "HomeShareInfo.h"
#import "MJExtension.h"
@implementation HomeShareInfo

static HomeShareInfo *homeShareInfo = nil;

 + (HomeShareInfo *)sharedHomeInfoModel{
    
     if( homeShareInfo == nil )
     {
         homeShareInfo = [ [ HomeShareInfo alloc ] init ];
         homeShareInfo.menuArray = [NSMutableArray array];
         
     }
     return homeShareInfo;
}

- (BOOL)isThroughAudit{
    
    if ([self.userInfo.group isEqualToString:@"2"]) {
        return YES;
    }else{
        return NO;
    }
}

- (UserInfo*)userInfo{
    
    if (!_userInfo) {
        _userInfo = [[UserInfo alloc]init];
        
    }
    NSDictionary *dic = [[JXUserDefault objectValueForKey:UserDefault_userInfo][@"data"] firstObject];
    _userInfo.customerid = dic[@"customerid"];
    _userInfo.email = dic[@"email"];
    _userInfo.group = dic[@"group"];
    _userInfo.session_id = dic[@"session_id"];
    return _userInfo;
}


@end