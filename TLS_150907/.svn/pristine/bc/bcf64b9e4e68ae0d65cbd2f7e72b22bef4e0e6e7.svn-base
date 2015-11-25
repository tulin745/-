//
//  CategorieInfo.m
//
//  Created by 淋 屠 on 15/8/20
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CategorieInfo.h"

//@property (nonatomic, assign) int parent_id;
//@property (nonatomic, strong) id mobile;
//@property (nonatomic, strong) id name;
//@property (nonatomic, copy) NSString *entity_id;
//@property (nonatomic, copy) NSString *children_ids;
@implementation CategorieInfo

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.parent_id = [aDecoder decodeIntForKey:@"parent_id"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.entity_id = [aDecoder decodeObjectForKey:@"entity_id"];
        self.children_ids = [aDecoder decodeObjectForKey:@"children_ids"];
      
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:self.parent_id forKey:@"parent_id"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.entity_id forKey:@"entity_id"];
    [aCoder encodeObject:self.children_ids forKey:@"children_ids"];

}


@end





