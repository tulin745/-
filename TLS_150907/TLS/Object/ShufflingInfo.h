//
//  ShufflingInfo.h
//  Noq
//
//  Created by mac on 15/05/25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

//轮播图对象
@interface ShufflingInfo : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *PicUrl;
@property (nonatomic, copy) NSString *PicLinkUrl;
@property (nonatomic, copy) NSString *Remark;
@property (nonatomic, copy) NSString *Spacing;
@property (nonatomic, copy) NSString *Sort;
@property (nonatomic, copy) NSString *Type;
@property (nonatomic, copy) NSString *CreateDate;

+ (NSArray *)paraseShufflingInfoWithData:(NSArray *)data;
@end
