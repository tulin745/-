//
//  NSString+Size.m
//  TLS
//
//  Created by 屠淋 on 15/10/13.
//  Copyright © 2015年 tulin. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)


//// 动态获得文字的size 高度
- (CGSize)getTextSizeWithString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    CGSize size;
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                options:(NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading)
                             attributes:attributesDictionary context:nil].size;
    return size;
}

//// 动态获得文字的size 宽度
- (CGSize)getTextSizeWithString:(NSString *)string font:(UIFont *)font Height:(CGFloat)Height
{
    CGSize size;
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, Height)
                                options:(NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading)
                             attributes:attributesDictionary context:nil].size;
    return size;
}

@end
