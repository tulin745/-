//
//  Networking.h
//  TLS
//
//  Created by 屠淋 on 15/8/18.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkName.h"
#import "AFNetworking.h"

#define Base_Url @"http://mobile.ltsecurityinc.com/api2/"
#define NET_URL @"http://mobile.ltsecurityinc.com/api2"

//http://www.ltsecurityinc.com/api/categories
//http://www.ltsecurityinc.com/api/config

typedef void(^requestSuccessBlock)(id dicResult);
typedef void(^requestErrorBlock)(id dicResult,NSString *error);

@interface Networking : NSObject

//get请求
+(void)getRequestWithHTTPName:(NSString*)httpName withSuccessBlock:(requestSuccessBlock)block withErrorBlock:(requestErrorBlock)errorBlock;


//afn请求
+ (void)GetAFNRequestWithParameters:(NSDictionary*)dic andHttpType:(NSString*)type action:(NSString*)action withSuccessBlock:(requestSuccessBlock)block withErrorBlock:(requestErrorBlock)errorBlock;

//Orders请求
+ (void)GetOrdersRequestWithParameters:(NSDictionary*)dic andHttpType:(NSString*)type action:(NSString*)action withSuccessBlock:(requestSuccessBlock)block withErrorBlock:(requestErrorBlock)errorBlock;

//下载文件接口
+ (void)downFileWithUrl:(NSString*)url andFileName:(NSString*)fileName andBlock:(void (^)(BOOL isSuccess, NSError *error))block;

@end
