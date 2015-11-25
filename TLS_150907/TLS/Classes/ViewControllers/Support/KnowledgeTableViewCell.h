//
//  KnowledgeTableViewCell.h
//  TLS
//
//  Created by newtouch on 15/8/25.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KnowledgeTableViewCell : BaseTableViewCell
@property (strong, nonatomic) IBOutlet UILabel *Question;
@property (strong, nonatomic) IBOutlet UILabel *QuestionDate;
@property (strong, nonatomic) IBOutlet UIImageView *cellImage;

@end
