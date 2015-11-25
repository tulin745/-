//
//  NSString+Size.h
//  TLS
//
//  Created by 屠淋 on 15/10/13.
//  Copyright © 2015年 tulin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

//计算高度
- (CGSize)getTextSizeWithString:(NSString *)string font:(UIFont *)font width:(CGFloat)width;

//// 动态获得文字的size 宽度
- (CGSize)getTextSizeWithString:(NSString *)string font:(UIFont *)font Height:(CGFloat)Height;

@end
