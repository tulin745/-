//
//  Promotions.m
//
//  Created by 淋 屠 on 15/8/20
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Promotions.h"


NSString *const kPromotionsModel = @"model";
NSString *const kPromotionsName = @"name";
NSString *const kPromotionsPrice = @"price";
NSString *const kPromotionsImage = @"image";


@interface Promotions ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Promotions

@synthesize model = _model;
@synthesize name = _name;
@synthesize price = _price;
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
            self.model = [self objectOrNilForKey:kPromotionsModel fromDictionary:dict];
            self.name = [self objectOrNilForKey:kPromotionsName fromDictionary:dict];
            self.price = [self objectOrNilForKey:kPromotionsPrice fromDictionary:dict];
            self.image = [self objectOrNilForKey:kPromotionsImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.model forKey:kPromotionsModel];
    [mutableDict setValue:self.name forKey:kPromotionsName];
    [mutableDict setValue:self.price forKey:kPromotionsPrice];
    [mutableDict setValue:self.image forKey:kPromotionsImage];

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

    self.model = [aDecoder decodeObjectForKey:kPromotionsModel];
    self.name = [aDecoder decodeObjectForKey:kPromotionsName];
    self.price = [aDecoder decodeObjectForKey:kPromotionsPrice];
    self.image = [aDecoder decodeObjectForKey:kPromotionsImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_model forKey:kPromotionsModel];
    [aCoder encodeObject:_name forKey:kPromotionsName];
    [aCoder encodeObject:_price forKey:kPromotionsPrice];
    [aCoder encodeObject:_image forKey:kPromotionsImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    Promotions *copy = [[Promotions alloc] init];
    
    if (copy) {

        copy.model = [self.model copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
    }
    
    return copy;
}


@end
