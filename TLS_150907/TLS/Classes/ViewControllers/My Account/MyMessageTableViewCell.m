//
//  MyMessageTableViewCell.m
//  TLS
//
//  Created by newtouch on 15/8/24.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "MyMessageTableViewCell.h"

@implementation MyMessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


//初始化cell类
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayuot];
    }
    return self;
}

-(void)initLayuot{
    _aqiImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 20, 20)];
    [self addSubview:_aqiImage];
    _aqiValue = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, SCREEN_WIDTH-70, 40)];
    _aqiValue.font = [UIFont systemFontOfSize:12];
    [self addSubview:_aqiValue];
}

-(void)setIntroductionText:(NSString*)text withColor:(UIColor*)textColor{
    
    
    _aqiImage.frame = CGRectMake(12, self.height - 10, 20, 20);
    
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    _aqiValue.text = text;
    _aqiValue.textColor = textColor;
    //设置label的最大行数
    _aqiValue.numberOfLines = 0;
    CGSize size = CGSizeMake(SCREEN_WIDTH-70, 1000);
    
//    CGSize labelSize = [_aqiValue.text sizeWithFont:_aqiValue.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];

    
    CGSize textSize = [_aqiValue.text boundingRectWithSize:size // 用于计算文本绘制时占据的矩形块
        options:NSStringDrawingUsesLineFragmentOrigin  // 文本绘制时的附加选项
        attributes: @{ NSFontAttributeName:_aqiValue.font }       // 文字的属性
        context:nil].size;
    
    //计算出自适应的高度
    if (textSize.height<40) {
        
        frame.size.height = 60;
        _aqiValue.frame = CGRectMake(_aqiValue.frame.origin.x, (frame.size.height-textSize.height)/2, textSize.width, textSize.height);
        
    }else{
        _aqiValue.frame = CGRectMake(_aqiValue.frame.origin.x, _aqiValue.frame.origin.y, textSize.width, textSize.height);
        frame.size.height = textSize.height+20;
        
    }
    UIImageView *separatorlineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.size.height-2, SCREEN_WIDTH, 2)];
    separatorlineView.image = [UIImage imageNamed:@"separatorline"];
    [self addSubview:separatorlineView];
    
    self.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end