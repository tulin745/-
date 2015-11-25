//
//  JXUserDefault.m
//  Noq
//
//  Created by mac on 14/10/28.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXUserDefault.h"

@implementation JXUserDefault

+ (NSUserDefaults*)userDefualts{
    static NSUserDefaults  *userDefaults = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userDefaults = [NSUserDefaults standardUserDefaults];
    });
    return userDefaults;
}

+ (void)setBooleanValue:(Boolean)value forKey:(NSString*)key{
    NSUserDefaults *user = [self userDefualts];
    [user setBool:value forKey:key];
    [user synchronize];
}

+ (Boolean)booleanValueForKey:(NSString*)key{
    NSUserDefaults *user = [self userDefualts];
    return [user boolForKey:key];
}

+ (void)setIntValue:(int)value forKey:(NSString*)key{
    NSUserDefaults *user = [self userDefualts];
    [user setInteger:value forKey:key];
    [user synchronize];
}

+ (int)intValueForKey:(NSString*)key{
    NSUserDefaults *user = [self userDefualts];
    return [user integerForKey:key];
}

+ (void)setFloatValue:(float)value forKey:(NSString*)key{
    NSUserDefaults *user = [self userDefualts];
    [user setFloat:value forKey:key];
    [user synchronize];
}

+ (float)floatValueForKey:(NSString*)key{
    NSUserDefaults *user = [self userDefualts];
    return [user floatForKey:key];
}

+ (void)setDoubleValue:(double)value forKey:(NSString*)key{
    NSUserDefaults *user = [self userDefualts];
    [user setDouble:value forKey:key];
    [user synchronize];
}

+ (double)doubleValueForKey:(NSString*)key{
    NSUserDefaults *user = [self userDefualts];
    return [user doubleForKey:key];
}

+ (void)setObjectValue:(id)value forKey:(NSString*)key{
    NSUserDefaults *user = [self userDefualts];
    [user setObject:value forKey:key];
    [user synchronize];
}

+ (id)objectValueForKey:(NSString*)key{
    NSUserDefaults *user = [self userDefualts];
    return [user objectForKey:key];
}

@end
