//
//  TextFieldWithIndexPath.h
//  CRM
//
//  Created by chunjia wei on 15-2-4.
//  Copyright (c) 2015年 wei. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kKey_code_textFieldValue @"code"
#define kKey_name_textFieldValue @"name"
#define kKey_index_textFieldValue @"index"


@interface TextFieldWithIndexPath : UITextField
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,strong) NSDictionary *dicValues;
@end
