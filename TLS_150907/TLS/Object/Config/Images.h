//
//  Images.h
//
//  Created by 淋 屠 on 15/8/20
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Images : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSDictionary *sliding;
@property (nonatomic, strong) NSString *whatsNewIcon;
@property (nonatomic, strong) NSString *promotionIcon;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end