//
//  HeadView.h
//  Test04
//
//  Created by HuHongbing on 9/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HeadViewDelegate; 

@interface HeadView : UIView{

    NSInteger section;
    UIButton* backBtn;
    BOOL open;
}
@property(nonatomic, assign) id<HeadViewDelegate> delegate;
@property(nonatomic, assign) NSInteger section;
@property(nonatomic, assign) BOOL open;
@property(nonatomic, retain) UIButton* backBtn;

@property (nonatomic, strong) UIButton *buttonV;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) NSArray *arrImages;

@property (nonatomic, strong) UIImageView *imageV;

@end

@protocol HeadViewDelegate <NSObject>
-(void)selectedWith:(HeadView *)view andBtn:(UIButton*)btn;
@end
