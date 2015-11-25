//
//  JXErrorInfo.h
//  Noq
//
//  Created by mac on 14/10/28.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

//--------------------------------------------------------------------------------------------------
/*
 *服务statekey
 */

typedef enum{
    JXErrorInfoTypeNone,              //无结果
    JXErrorInfoTypeInvalidParas = -9, //输入参数异常
    JXErrorInfoTypeUnRegisteredDevice = -11,//未注册设备
    JXErrorInfoTypeParamFailed = -13,//参数校验未通过
    JXErrorInfoTypeSuccessfulNoData = -15,  //成功但没数据
}JXErrorInfoType;

@interface JXErrorInfo : NSObject

@property (nonatomic, strong) NSString *errInfo;
@property (nonatomic, strong) NSString *errCode;
@property (nonatomic, strong) NSString *errID;
@property (nonatomic, assign) JXErrorInfoType errType;

- (instancetype)initWithErrorType:(JXErrorInfoType)type errorInfo:(NSString*)info errCode:(NSString*)codeInfo;
@end
