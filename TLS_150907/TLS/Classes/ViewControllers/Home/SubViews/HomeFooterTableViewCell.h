//
//  HomeFooterCollectionViewCell.h
//  TLS
//
//  Created by 屠淋 on 15/8/10.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeFooterTableViewCellDelegate  <NSObject>

- (void)openFileAction:(UIButton*)button;

@end

@interface HomeFooterTableViewCell : BaseTableViewCell

@property (nonatomic, assign) id<HomeFooterTableViewCellDelegate>delegate;

@property (nonatomic, strong) NSArray *version;


@end
