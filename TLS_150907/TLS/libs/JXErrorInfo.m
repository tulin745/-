//
//  JXErrorInfo.m
//  Noq
//
//  Created by mac on 14/10/28.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXErrorInfo.h"

@implementation JXErrorInfo

+ (NSString *)errorWithCode:(JXErrorInfoType )code{
    static NSDictionary *errDic = nil;
    if (!errDic) {
        NSString *file = [NSString fileBundlePath:@"ErrorFile.plist" type:nil];
        errDic = [NSDictionary dictionaryWithContentsOfFile:file];
    }
    NSString *err= [errDic valueForKey:[NSString stringWithFormat:@"%d",code]];
    return [err length]?err:@"未知错误";
}

- (instancetype)initWithErrorType:(JXErrorInfoType)type errorInfo:(NSString*)info errCode:(NSString*)codeInfo{
    self = [super init];
    if (self) {
        _errType = type;
        _errInfo = [info length]?info:@"操作发生错误";
        if (_errType != JXErrorInfoTypeNone) {
         _errInfo = [[NSString alloc] initWithString:[JXErrorInfo errorWithCode:_errType]];
        }
        else {
             if (![_errInfo isEqualToString:@"操作发生错误"]) {
                 
                 _errInfo = [[NSString alloc] initWithString:info];
                 _errCode= [[NSString alloc] initWithString:codeInfo];
        
             }else
             {
                 _errInfo = [[NSString alloc] initWithString:_errInfo];
                 _errCode = @"服务器返回解析错误";
                 
             }
        }
    }
    return self;
}

@end
