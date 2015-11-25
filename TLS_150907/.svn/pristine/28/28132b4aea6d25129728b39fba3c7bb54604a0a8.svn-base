//
//  Contacts.m
//
//  Created by 淋 屠 on 15/8/20
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Contacts.h"


NSString *const kContactsOffice = @"office";
NSString *const kContactsFax = @"fax";
NSString *const kContactsAddr1 = @"addr1";
NSString *const kContactsNote = @"note";
NSString *const kContactsHours = @"hours";
NSString *const kContactsEmail = @"email";
NSString *const kContactsAddr2 = @"addr2";
NSString *const kContactsTel = @"tel";
NSString *const kContactsTollFree = @"toll_free";


@interface Contacts ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Contacts

@synthesize office = _office;
@synthesize fax = _fax;
@synthesize addr1 = _addr1;
@synthesize note = _note;
@synthesize hours = _hours;
@synthesize email = _email;
@synthesize addr2 = _addr2;
@synthesize tel = _tel;
@synthesize tollFree = _tollFree;


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
            self.office = [self objectOrNilForKey:kContactsOffice fromDictionary:dict];
            self.fax = [self objectOrNilForKey:kContactsFax fromDictionary:dict];
            self.addr1 = [self objectOrNilForKey:kContactsAddr1 fromDictionary:dict];
            self.note = [self objectOrNilForKey:kContactsNote fromDictionary:dict];
            self.hours = [self objectOrNilForKey:kContactsHours fromDictionary:dict];
            self.email = [self objectOrNilForKey:kContactsEmail fromDictionary:dict];
            self.addr2 = [self objectOrNilForKey:kContactsAddr2 fromDictionary:dict];
            self.tel = [self objectOrNilForKey:kContactsTel fromDictionary:dict];
            self.tollFree = [self objectOrNilForKey:kContactsTollFree fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.office forKey:kContactsOffice];
    [mutableDict setValue:self.fax forKey:kContactsFax];
    [mutableDict setValue:self.addr1 forKey:kContactsAddr1];
    [mutableDict setValue:self.note forKey:kContactsNote];
    [mutableDict setValue:self.hours forKey:kContactsHours];
    [mutableDict setValue:self.email forKey:kContactsEmail];
    [mutableDict setValue:self.addr2 forKey:kContactsAddr2];
    [mutableDict setValue:self.tel forKey:kContactsTel];
    [mutableDict setValue:self.tollFree forKey:kContactsTollFree];

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

    self.office = [aDecoder decodeObjectForKey:kContactsOffice];
    self.fax = [aDecoder decodeObjectForKey:kContactsFax];
    self.addr1 = [aDecoder decodeObjectForKey:kContactsAddr1];
    self.note = [aDecoder decodeObjectForKey:kContactsNote];
    self.hours = [aDecoder decodeObjectForKey:kContactsHours];
    self.email = [aDecoder decodeObjectForKey:kContactsEmail];
    self.addr2 = [aDecoder decodeObjectForKey:kContactsAddr2];
    self.tel = [aDecoder decodeObjectForKey:kContactsTel];
    self.tollFree = [aDecoder decodeObjectForKey:kContactsTollFree];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_office forKey:kContactsOffice];
    [aCoder encodeObject:_fax forKey:kContactsFax];
    [aCoder encodeObject:_addr1 forKey:kContactsAddr1];
    [aCoder encodeObject:_note forKey:kContactsNote];
    [aCoder encodeObject:_hours forKey:kContactsHours];
    [aCoder encodeObject:_email forKey:kContactsEmail];
    [aCoder encodeObject:_addr2 forKey:kContactsAddr2];
    [aCoder encodeObject:_tel forKey:kContactsTel];
    [aCoder encodeObject:_tollFree forKey:kContactsTollFree];
}

- (id)copyWithZone:(NSZone *)zone
{
    Contacts *copy = [[Contacts alloc] init];
    
    if (copy) {

        copy.office = [self.office copyWithZone:zone];
        copy.fax = [self.fax copyWithZone:zone];
        copy.addr1 = [self.addr1 copyWithZone:zone];
        copy.note = [self.note copyWithZone:zone];
        copy.hours = [self.hours copyWithZone:zone];
        copy.email = [self.email copyWithZone:zone];
        copy.addr2 = [self.addr2 copyWithZone:zone];
        copy.tel = [self.tel copyWithZone:zone];
        copy.tollFree = [self.tollFree copyWithZone:zone];
    }
    
    return copy;
}


@end
