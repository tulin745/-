//
//  ShufflingInfo.m
//  Noq
//
//  Created by mac on 14/11/17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ShufflingInfo.h"

@implementation ShufflingInfo

+ (NSArray *)paraseShufflingInfoWithData:(NSArray *)data
{
    if (!data) {
        return nil;
    }
    NSMutableArray *reArray = [NSMutableArray arrayWithCapacity:[data count]];
    for (int i = 0; i < [data count]; i++) {
        NSDictionary *dic = [data objectAtIndex:i];
        ShufflingInfo *info = [[ShufflingInfo alloc] init];
        //info.ID = [dic valueForKey:@"ID"];
        info.Title = [dic valueForKey:@"Title"];
        info.PicUrl = [dic valueForKey:@"PicUrl"];
//        info.PicLinkUrl = [dic valueForKey:@"PicLinkUrl"];
//        info.Remark = [dic valueForKey:@"Remark"];
//        info.Spacing = [[dic valueForKey:@"Spacing"] stringValue];
//        info.Sort = [dic valueForKey:@"Sort"];
//        info.Type = [dic valueForKey:@"Type"];
//        info.CreateDate = [dic valueForKey:@"CreateDate"];
        [reArray addObject:info];
    }
    return reArray;
}
@end
