//
//  BaseViewController.h
//  ECTECTIphone
//
//  Created by mac on 15/5/19.
//
//

#import <UIKit/UIKit.h>

#import "ShopCartView.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) ShopCartView *cartView;

- (void)addItemsToCart;

-(void)backPage;

-(void)dissPage;

-(void)rightBtnAction;

- (void)setLelftNavigationItem:(BOOL)hidden;

- (void)setMenuLeftItem;

- (void)setShopRightItem;

- (void)rightButton:(UIButton*)button;


@end