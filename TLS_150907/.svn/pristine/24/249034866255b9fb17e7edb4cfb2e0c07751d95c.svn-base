//
//  MyCartTableViewCell.h
//  TLS
//
//  Created by 屠淋 on 15/8/22.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCartTableViewCellDelegate <NSObject>

- (void)updateItemWithStr:(NSString*)itemQty andIndexPath:(NSIndexPath*)indexPath;
- (void)selectedGOODs:(UIButton*)button andIndexPath:(NSIndexPath *)indexPath;

@end

@interface MyCartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) id<MyCartTableViewCellDelegate>delegate;
- (void)getContentWithDic:(NSDictionary*)dic;
@end
