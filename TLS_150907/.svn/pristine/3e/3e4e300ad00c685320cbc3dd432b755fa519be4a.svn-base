//
//  Images.m
//
//  Created by 淋 屠 on 15/8/20
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Images.h"


NSString *const kImagesSliding = @"sliding";
NSString *const kImagesWhatsNewIcon = @"whats_new_icon";
NSString *const kImagesPromotionIcon = @"promotions_icon";


@interface Images ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Images

@synthesize sliding = _sliding;
@synthesize whatsNewIcon = _whatsNewIcon;
@synthesize promotionIcon = _promotionIcon;


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
            self.sliding = [self objectOrNilForKey:kImagesSliding fromDictionary:dict];
            self.whatsNewIcon = [self objectOrNilForKey:kImagesWhatsNewIcon fromDictionary:dict];
            self.promotionIcon = [self objectOrNilForKey:kImagesPromotionIcon fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForSliding = [NSMutableArray array];
    for (NSObject *subArrayObject in self.sliding) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSliding addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSliding addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSliding] forKey:kImagesSliding];
    [mutableDict setValue:self.whatsNewIcon forKey:kImagesWhatsNewIcon];
    [mutableDict setValue:self.promotionIcon forKey:kImagesPromotionIcon];

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

    self.sliding = [aDecoder decodeObjectForKey:kImagesSliding];
    self.whatsNewIcon = [aDecoder decodeObjectForKey:kImagesWhatsNewIcon];
    self.promotionIcon = [aDecoder decodeObjectForKey:kImagesPromotionIcon];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_sliding forKey:kImagesSliding];
    [aCoder encodeObject:_whatsNewIcon forKey:kImagesWhatsNewIcon];
    [aCoder encodeObject:_promotionIcon forKey:kImagesPromotionIcon];
}

- (id)copyWithZone:(NSZone *)zone
{
    Images *copy = [[Images alloc] init];
    
    if (copy) {

        copy.sliding = [self.sliding copyWithZone:zone];
        copy.whatsNewIcon = [self.whatsNewIcon copyWithZone:zone];
        copy.promotionIcon = [self.promotionIcon copyWithZone:zone];
    }
    
    return copy;
}


@end
