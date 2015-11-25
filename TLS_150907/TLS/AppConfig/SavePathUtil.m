//
//  SavePathUtil.m
//  TLS
//
//  Created by 屠淋 on 15/9/4.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "SavePathUtil.h"
#import "SynthesizeSingleton.h"

@implementation SavePathUtil

SYNTHESIZE_SINGLETON_FOR_CLASS(SavePathUtil)

+ (NSString *)getDocumentPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docDir = [paths objectAtIndex:0];
    return docDir;
}

/**ip_PDF的path*/
+ (NSString *)getIPPDFPath{
    NSString *docDir = [self getDocumentPath];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"IP-PDF.pdf"];
    return filePath;
}

/**ip_PDF的path*/
+ (NSString *)getHDTVPath{
    NSString *docDir = [self getDocumentPath];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"HDTV-PDF.pdf"];
    return filePath;
}

+ (NSString *)getVersonOnePDFPath{
    NSString *docDir = [self getDocumentPath];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"Verson1-PDF.pdf"];
    return filePath;
}

+ (NSString *)getVersonTwoPDFPath{
    NSString *docDir = [self getDocumentPath];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"Verson2-PDF.pdf"];
    return filePath;
}

@end
