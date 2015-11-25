//
//  Video.m
//
//  Created by 淋 屠 on 15/8/20
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Video.h"


NSString *const kVideoType = @"type";
NSString *const kVideoUrl = @"url";
NSString *const kVideoImage = @"image";


@interface Video ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Video

@synthesize type = _type;
@synthesize url = _url;
@synthesize image = _image;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.type = [self objectOrNilForKey:kVideoType fromDictionary:dict];
            self.url = [self objectOrNilForKey:kVideoUrl fromDictionary:dict];
            self.image = [self objectOrNilForKey:kVideoImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.type forKey:kVideoType];
    [mutableDict setValue:self.url forKey:kVideoUrl];
    [mutableDict setValue:self.image forKey:kVideoImage];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.type = [aDecoder decodeObjectForKey:kVideoType];
    self.url = [aDecoder decodeObjectForKey:kVideoUrl];
    self.image = [aDecoder decodeObjectForKey:kVideoImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_type forKey:kVideoType];
    [aCoder encodeObject:_url forKey:kVideoUrl];
    [aCoder encodeObject:_image forKey:kVideoImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    Video *copy = [[Video alloc] init];
    
    if (copy) {

        copy.type = [self.type copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
    }
    
    return copy;
}


@end
