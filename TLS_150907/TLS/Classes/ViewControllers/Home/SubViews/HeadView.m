//
//  HeadView.m
//  Test04
//
//  Created by HuHongbing on 9/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeadView.h"

@interface HeadView()



@end

@implementation HeadView
@synthesize delegate = _delegate;
@synthesize section,open,backBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        open = NO;
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.image = [UIImage imageNamed:@"categories"];
        [self addSubview:imageV];
        self.imageV = imageV;
        
        UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, frame.size.width / 2, frame.size.height)];
        labe.font = [UIFont systemFontOfSize:15];
        labe.textColor = [UIColor blackColor];
        [self addSubview:labe];
        self.label = labe;
        
        UIButton *buttonV = [UIButton buttonWithType:UIButtonTypeCustom];

        [buttonV addTarget:self action:@selector(doSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonV];
        self.buttonV = buttonV;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 0.5,frame.size.width , 0.5)];
        lineView.backgroundColor = UIColorFromRGB(0xe9e9e9);
        [self addSubview:lineView];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(doSelected:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 10000;
        [self addSubview:btn];
        self.backBtn = btn;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageV.frame = CGRectMake(10,self.height/2 - 7.5, 15, 15);
    
    self.buttonV.frame = CGRectMake(self.width - 50, 0, 40, self.height);
    self.buttonV.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    self.backBtn.frame = CGRectMake(0, 0, self.width - 50, self.height);
    
    self.label.frame = CGRectMake(self.imageV.right + 10, 0, self.width / 3 *2, self.height);
    
    UIImage *image1 = [UIImage imageNamed:self.arrImages[0]];
    UIImage *image2 = [UIImage imageNamed:self.arrImages[1]];

    [self.buttonV setImage:image1 forState:UIControlStateNormal];
    [self.buttonV setImage:image2 forState:UIControlStateSelected];
}

-(void)doSelected:(UIButton*)btn{

    if (_delegate && [_delegate respondsToSelector:@selector(selectedWith:andBtn:)]){
        
     	[_delegate selectedWith:self andBtn:btn];
        
    }
}
@end
