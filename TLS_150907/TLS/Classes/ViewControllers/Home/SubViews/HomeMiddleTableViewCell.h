//
//  HomeMiddleCollectionViewCell.h
//  TLS
//
//  Created by 屠淋 on 15/8/10.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Images.h"

@protocol HomeMiddleTableViewCellDelegate <NSObject>

- (void)HomeMiddleCell:(UIButton*)btn;

@end
@interface HomeMiddleTableViewCell : BaseTableViewCell

@property (nonatomic, assign) id<HomeMiddleTableViewCellDelegate>delegate;

@property (nonatomic, strong) Images *imageInfo;

@end
