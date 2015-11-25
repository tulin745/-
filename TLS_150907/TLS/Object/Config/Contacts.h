//
//  Contacts.h
//
//  Created by 淋 屠 on 15/8/20
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Contacts : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *office;
@property (nonatomic, strong) NSString *fax;
@property (nonatomic, strong) NSString *addr1;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) NSString *hours;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *addr2;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *tollFree;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
