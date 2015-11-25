//
//  BaseClass.h
//
//  Created by 淋 屠 on 15/8/20
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Video.h"
#import "Images.h"
#import "Contacts.h"
#import "Promotions.h"

@interface BaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *video;
@property (nonatomic, strong) Images *images;
@property (nonatomic, strong) NSArray *contacts;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSArray *promotions;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDictionary *knowledgebase;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
