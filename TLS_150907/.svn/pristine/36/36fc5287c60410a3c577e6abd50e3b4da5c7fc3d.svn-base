//
//  BaseClass.m
//
//  Created by 淋 屠 on 15/8/20
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BaseClass.h"



NSString *const kBaseClassVideo = @"videos";
NSString *const kBaseClassImages = @"images";
NSString *const kBaseClassContacts = @"contacts";
NSString *const kBaseClassVersion = @"version";
NSString *const kBaseClassPromotions = @"promotions";
NSString *const kBaseClassName = @"name";
NSString *const kBaseClassKnowledgebase = @"Knowledge Base";


@interface BaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BaseClass

@synthesize video = _video;
@synthesize images = _images;
@synthesize contacts = _contacts;
@synthesize version = _version;
@synthesize promotions = _promotions;
@synthesize name = _name;
@synthesize knowledgebase = _knowledgebase;


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
    NSObject *receivedVideo = [dict objectForKey:kBaseClassVideo];
    NSMutableArray *parsedVideo = [NSMutableArray array];
    if ([receivedVideo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedVideo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedVideo addObject:[Video modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedVideo isKindOfClass:[NSDictionary class]]) {
       [parsedVideo addObject:[Video modelObjectWithDictionary:(NSDictionary *)receivedVideo]];
    }

    self.video = [NSArray arrayWithArray:parsedVideo];
            self.images = [Images modelObjectWithDictionary:[dict objectForKey:kBaseClassImages]];
    NSObject *receivedContacts = [dict objectForKey:kBaseClassContacts];
    NSMutableArray *parsedContacts = [NSMutableArray array];
    if ([receivedContacts isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedContacts) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedContacts addObject:[Contacts modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedContacts isKindOfClass:[NSDictionary class]]) {
       [parsedContacts addObject:[Contacts modelObjectWithDictionary:(NSDictionary *)receivedContacts]];
    }

    self.contacts = [NSArray arrayWithArray:parsedContacts];
            self.version = [self objectOrNilForKey:kBaseClassVersion fromDictionary:dict];
   
        NSArray *receivedPromotions = [dict objectForKey:kBaseClassPromotions];
//    NSMutableArray *parsedPromotions = [NSMutableArray array];
//    if ([receivedPromotions isKindOfClass:[NSArray class]]) {
//        for (NSDictionary *item in (NSArray *)receivedPromotions) {
//            if ([item isKindOfClass:[NSDictionary class]]) {
//                [parsedPromotions addObject:[Promotions modelObjectWithDictionary:item]];
//            }
//       }
//    } else if ([receivedPromotions isKindOfClass:[NSDictionary class]]) {
//       [parsedPromotions addObject:[Promotions modelObjectWithDictionary:(NSDictionary *)receivedPromotions]];
//    }

    self.promotions = [NSArray arrayWithArray:receivedPromotions];
        self.name = [self objectOrNilForKey:kBaseClassName fromDictionary:dict];
        
    NSDictionary *receivedKnowledgebase = [dict objectForKey:kBaseClassKnowledgebase];
//    NSMutableArray *parsedKnowledgebase = [NSMutableArray array];
//    if ([receivedKnowledgebase isKindOfClass:[NSArray class]]) {
//        for (NSDictionary *item in (NSArray *)receivedKnowledgebase) {
//            if ([item isKindOfClass:[NSDictionary class]]) {
//                [parsedKnowledgebase addObject:[Knowledgebase modelObjectWithDictionary:item]];
//            }
//       }
//    } else if ([receivedKnowledgebase isKindOfClass:[NSDictionary class]]) {
//       [parsedKnowledgebase addObject:[Knowledgebase modelObjectWithDictionary:(NSDictionary *)receivedKnowledgebase]];
//    }

    self.knowledgebase = [NSDictionary dictionaryWithDictionary:receivedKnowledgebase];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForVideo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.video) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForVideo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForVideo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForVideo] forKey:kBaseClassVideo];
    [mutableDict setValue:[self.images dictionaryRepresentation] forKey:kBaseClassImages];
    NSMutableArray *tempArrayForContacts = [NSMutableArray array];
    for (NSObject *subArrayObject in self.contacts) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForContacts addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForContacts addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForContacts] forKey:kBaseClassContacts];
    [mutableDict setValue:self.version forKey:kBaseClassVersion];
    NSMutableArray *tempArrayForPromotions = [NSMutableArray array];
    for (NSObject *subArrayObject in self.promotions) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPromotions addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPromotions addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPromotions] forKey:kBaseClassPromotions];
    [mutableDict setValue:self.name forKey:kBaseClassName];
//    NSMutableArray *tempArrayForKnowledgebase = [NSMutableArray array];
//    for (NSObject *subArrayObject in self.knowledgebase) {
//        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
//            // This class is a model object
//            [tempArrayForKnowledgebase addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
//        } else {
//            // Generic object
//            [tempArrayForKnowledgebase addObject:subArrayObject];
//        }
//    }
//    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForKnowledgebase] forKey:kBaseClassKnowledgebase];

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

    self.video = [aDecoder decodeObjectForKey:kBaseClassVideo];
    self.images = [aDecoder decodeObjectForKey:kBaseClassImages];
    self.contacts = [aDecoder decodeObjectForKey:kBaseClassContacts];
    self.version = [aDecoder decodeObjectForKey:kBaseClassVersion];
    self.promotions = [aDecoder decodeObjectForKey:kBaseClassPromotions];
    self.name = [aDecoder decodeObjectForKey:kBaseClassName];
//    self.knowledgebase = [aDecoder decodeObjectForKey:kBaseClassKnowledgebase];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_video forKey:kBaseClassVideo];
    [aCoder encodeObject:_images forKey:kBaseClassImages];
    [aCoder encodeObject:_contacts forKey:kBaseClassContacts];
    [aCoder encodeObject:_version forKey:kBaseClassVersion];
    [aCoder encodeObject:_promotions forKey:kBaseClassPromotions];
    [aCoder encodeObject:_name forKey:kBaseClassName];
//    [aCoder encodeObject:_knowledgebase forKey:kBaseClassKnowledgebase];
}

- (id)copyWithZone:(NSZone *)zone
{
    BaseClass *copy = [[BaseClass alloc] init];
    
    if (copy) {

        copy.video = [self.video copyWithZone:zone];
        copy.images = [self.images copyWithZone:zone];
        copy.contacts = [self.contacts copyWithZone:zone];
        copy.version = [self.version copyWithZone:zone];
        copy.promotions = [self.promotions copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.knowledgebase = [self.knowledgebase copyWithZone:zone];
    }
    
    return copy;
}


@end
