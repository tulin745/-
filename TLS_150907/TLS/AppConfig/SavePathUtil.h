//
//  SavePathUtil.h
//  TLS
//
//  Created by 屠淋 on 15/9/4.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SavePathUtil : NSObject

+(SavePathUtil *)sharedSavePathUtil;


+ (NSString *)getIPPDFPath;

+ (NSString *)getHDTVPath;

+ (NSString *)getVersonOnePDFPath;

+ (NSString *)getVersonTwoPDFPath;

@end
