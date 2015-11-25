//
//  VideoView.h
//  TLS
//
//  Created by 屠淋 on 15/9/11.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoView;

@protocol VideoViewDelegate <NSObject>

- (void)VideoViewPush:(VideoView*)view andURl:(NSString*)url;

@end
@interface VideoView : UIView

@property (nonatomic, assign) id<VideoViewDelegate>delegate;

@end
