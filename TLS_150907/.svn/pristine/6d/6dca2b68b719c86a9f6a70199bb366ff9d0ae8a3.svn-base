//
//  SGFocusImageItem.m
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//

#import "SGFocusImageItem.h"

#define kSGTitleKey @"title"
#define kSGImageKey @"image"

@implementation SGFocusImageItem
@synthesize title = _title;
@synthesize image = _image;
//@synthesize tag = _tag;
//@synthesize linkURL = _linkURL;

- (id)initWithTitle:(NSString *)title image:(NSString *)image tag:(NSInteger)tag 
{
    self = [super init];
    if (self) {
        self.title = title;
        self.image = image;
        //self.tag = tag;
        
    }
    
    return self;
}

- (id)initWithDict:(NSDictionary *)dict tag:(NSInteger)tag
{
    self = [super init];
    if (self)
    {
        if ([dict isKindOfClass:[NSDictionary class]])
        {
            self.title = [dict objectForKey:kSGTitleKey];
            self.image = [dict objectForKey:kSGImageKey];
            //...
        }
    }
    return self;
}

- (id)initWithShufflingInfo:(ShufflingInfo *)info
{
    self = [super init];
    if (self) {
        self.title = info.Title;
        self.image = info.PicUrl;
//        self.tag = [info.ID intValue];
//        self.linkURL = info.PicLinkUrl;
    }
    return self;
}

@end
