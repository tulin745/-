//
//  UINavigationBar+CustomImage.m
//  PAWangLiTong
//
//  Created by Tommy's iMac on 1/7/13.
//  Copyright (c) 2013 Tommy's iMac. All rights reserved.
//

#import "UINavigationBar+CustomImage.h"
#import <objc/runtime.h>

@implementation UINavigationBar (CustomImage)

- (void)setCustomizeImage:(UIImage *)image
			forBarMetrics:(UIBarMetrics)metrices
{
	UIImageView *imageView = (UIImageView *)[self viewWithTag:8899];
	if (imageView == nil) {
		imageView = [[UIImageView alloc] initWithImage:image];
		[imageView setTag:0xABCDEF];
		[self insertSubview:imageView atIndex:0];
//		[imageView release];
	}
}

-(void)setCustomBackgroundImage:(UIImage *)image
{
    if (![UINavigationBar instancesRespondToSelector:
          @selector(setBackgroundImage:forBarMetrics:)]) //查询是否有方法，没有则用新的替换掉
    {
        Class c = [UINavigationBar class];
        SEL origSEL = @selector(setBackgroundImage:forBarMetrics:);
        SEL newSEL = @selector(setCustomizeImage:forBarMetrics:);
        
        Method origMethod = class_getInstanceMethod(c, origSEL);
        Method newMethod = class_getInstanceMethod(c, newSEL);
        
        if(class_addMethod(c, origSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
            class_replaceMethod(c, newSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        else
            method_exchangeImplementations(origMethod, newMethod);
    }

    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

@end
