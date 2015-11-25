//
//  UIView+Hierarchy.m
// https://github.com/hackiftekhar/IQKeyboardManager
// Copyright (c) 2013-15 Iftekhar Qurashi.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "IQUIView+Hierarchy.h"

#ifdef NSFoundationVersionNumber_iOS_5_1
#import <UIKit/UICollectionView.h>
#endif

#import <UIKit/UITableView.h>
#import <UIKit/UITextView.h>
#import <UIKit/UITextField.h>
#import <UIKit/UISearchBar.h>
#import <UIKit/UIViewController.h>
#import <UIKit/UIWindow.h>

#import <objc/runtime.h>

@implementation UIView (IQ_UIView_Hierarchy)

//Special textFields,textViews,scrollViews
Class UIAlertSheetTextFieldClass;       //UIAlertView
Class UIAlertSheetTextFieldClass_iOS8;  //UIAlertView

Class UITableViewCellScrollViewClass;   //UITableViewCell
Class UITableViewWrapperViewClass;      //UITableViewCell
Class UIQueuingScrollViewClass;         //UIPageViewController

Class UISearchBarTextFieldClass;        //UISearchBar

+(void)initialize
{
    [super initialize];
    
    UIAlertSheetTextFieldClass          = NSClassFromString(@"UIAlertSheetTextField");
    UIAlertSheetTextFieldClass_iOS8     = NSClassFromString(@"_UIAlertControllerTextField");
    
    UITableViewCellScrollViewClass      = NSClassFromString(@"UITableViewCellScrollView");
    UITableViewWrapperViewClass         = NSClassFromString(@"UITableViewWrapperView");
    UIQueuingScrollViewClass            = NSClassFromString(@"_UIQueuingScrollView");

    UISearchBarTextFieldClass           = NSClassFromString(@"UISearchBarTextField");
}

-(void)_setIsAskingCanBecomeFirstResponder:(BOOL)isAskingCanBecomeFirstResponder
{
    objc_setAssociatedObject(self, @selector(isAskingCanBecomeFirstResponder), [NSNumber numberWithBool:isAskingCanBecomeFirstResponder], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isAskingCanBecomeFirstResponder
{
    NSNumber *isAskingCanBecomeFirstResponder = objc_getAssociatedObject(self, @selector(isAskingCanBecomeFirstResponder));
    return [isAskingCanBecomeFirstResponder boolValue];
}

-(UIViewController*)viewController
{
    UIResponder *nextResponder =  self;
    
    do
    {
        nextResponder = [nextResponder nextResponder];

        if ([nextResponder isKindOfClass:[UIViewController class]])
            return (UIViewController*)nextResponder;

    } while (nextResponder != nil);

    return nil;
}

-(UIViewController *)topMostController
{
    NSMutableArray *controllersHierarchy = [[NSMutableArray alloc] init];
    
    UIViewController *topController = self.window.rootViewController;
    
    if (topController)
    {
        [controllersHierarchy addObject:topController];
    }
    
    while ([topController presentedViewController]) {
        
        topController = [topController presentedViewController];
        [controllersHierarchy addObject:topController];
    }
    
    UIResponder *matchController = [self viewController];
    
    while (matchController != nil && [controllersHierarchy containsObject:matchController] == NO)
    {
        do
        {
            matchController = [matchController nextResponder];
            
        } while (matchController != nil && [matchController isKindOfClass:[UIViewController class]] == NO);
    }
    
    return (UIViewController*)matchController;
}

-(UIView*)superviewOfClassType:(Class)classType
{
    UIView *superview = self.superview;
    
    while (superview)
    {
        if ([superview isKindOfClass:classType] &&
            ([superview isKindOfClass:UITableViewCellScrollViewClass] == NO) &&
            ([superview isKindOfClass:UITableViewWrapperViewClass] == NO) &&
            ([superview isKindOfClass:UIQueuingScrollViewClass] == NO))
        {
            return superview;
        }
        else    superview = superview.superview;
    }
    
    return nil;
}

-(BOOL)_IQcanBecomeFirstResponder
{
    [self _setIsAskingCanBecomeFirstResponder:YES];
    BOOL _IQcanBecomeFirstResponder = ([self canBecomeFirstResponder] && [self isUserInteractionEnabled] && ![self isHidden] && [self alpha]!=0.0 && ![self isAlertViewTextField]  && ![self isSearchBarTextField]);
    
    if (_IQcanBecomeFirstResponder == YES)
    {
        if ([self isKindOfClass:[UITextField class]])
        {
            _IQcanBecomeFirstResponder = [(UITextField*)self isEnabled];
        }
        else if ([self isKindOfClass:[UITextView class]])
        {
            _IQcanBecomeFirstResponder = [(UITextView*)self isEditable];
        }
    }
    
    [self _setIsAskingCanBecomeFirstResponder:NO];
    
    return _IQcanBecomeFirstResponder;
}

- (NSArray*)responderSiblings
{
    //	Getting all siblings
    NSArray *siblings = self.superview.subviews;
    
    //Array of (UITextField/UITextView's).
    NSMutableArray *tempTextFields = [[NSMutableArray alloc] init];
    
    for (UITextField *textField in siblings)
        if ([textField _IQcanBecomeFirstResponder])
            [tempTextFields addObject:textField];
    
    return tempTextFields;
}

- (NSArray*)deepResponderViews
{
    NSMutableArray *textFields = [[NSMutableArray alloc] init];
    
    //subviews are returning in opposite order. So I sorted it according the frames 'y'.
    NSArray *subViews = [self.subviews sortedArrayUsingComparator:^NSComparisonResult(UIView *view1, UIView *view2) {
        
        CGFloat x1 = CGRectGetMinX(view1.frame);
        CGFloat y1 = CGRectGetMinY(view1.frame);
        CGFloat x2 = CGRectGetMinX(view2.frame);
        CGFloat y2 = CGRectGetMinY(view2.frame);
        
        if (y1 < y2)  return NSOrderedAscending;
        
        else if (y1 > y2) return NSOrderedDescending;
        
        //Else both y are same so checking for x positions
        else if (x1 < x2)  return NSOrderedAscending;
        
        else if (x1 > x2) return NSOrderedDescending;
        
        else    return NSOrderedSame;
    }];

    for (UITextField *textField in subViews)
    {
        if ([textField _IQcanBecomeFirstResponder])
        {
            [textFields addObject:textField];
        }
        else if (textField.subviews.count)
        {
            [textFields addObjectsFromArray:[textField deepResponderViews]];
        }
    }

    return textFields;
}

-(CGAffineTransform)convertTransformToView:(UIView*)toView
{
    if (toView == nil)
    {
        toView = self.window;
    }
    
    CGAffineTransform myTransform = CGAffineTransformIdentity;
    
    //My Transform
    {
        UIView *superView = [self superview];
        
        if (superView)  myTransform = CGAffineTransformConcat(self.transform, [superView convertTransformToView:nil]);
        else            myTransform = self.transform;
    }
    
    CGAffineTransform viewTransform = CGAffineTransformIdentity;
    
    //view Transform
    {
        UIView *superView = [toView superview];
        
        if (superView)  viewTransform = CGAffineTransformConcat(toView.transform, [superView convertTransformToView:nil]);
        else if (toView)  viewTransform = toView.transform;
    }
    
    return CGAffineTransformConcat(myTransform, CGAffineTransformInvert(viewTransform));
}


- (NSInteger)depth
{
    NSInteger depth = 0;
    
    if ([self superview])
    {
        depth = [[self superview] depth] + 1;
    }
    
    return depth;
}

- (NSString *)subHierarchy
{
    NSMutableString *debugInfo = [[NSMutableString alloc] initWithString:@"\n"];
    NSInteger depth = [self depth];
    
    for (int counter = 0; counter < depth; counter ++)  [debugInfo appendString:@"|  "];
    
    [debugInfo appendString:[self debugHierarchy]];
    
    for (UIView *subview in self.subviews)
    {
        [debugInfo appendString:[subview subHierarchy]];
    }
    
    return debugInfo;
}

- (NSString *)superHierarchy
{
    NSMutableString *debugInfo = [[NSMutableString alloc] init];

    if (self.superview)
    {
        [debugInfo appendString:[self.superview superHierarchy]];
    }
    else
    {
        [debugInfo appendString:@"\n"];
    }
    
    NSInteger depth = [self depth];
    
    for (int counter = 0; counter < depth; counter ++)  [debugInfo appendString:@"|  "];
    
    [debugInfo appendString:[self debugHierarchy]];

    [debugInfo appendString:@"\n"];
    
    return debugInfo;
}

-(NSString *)debugHierarchy
{
    NSMutableString *debugInfo = [[NSMutableString alloc] init];

    [debugInfo appendFormat:@"%@: ( %.0f, %.0f, %.0f, %.0f )",NSStringFromClass([self class]), CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)];
    
    if ([self isKindOfClass:[UIScrollView class]])
    {
        UIScrollView *scrollView = (UIScrollView*)self;
        [debugInfo appendFormat:@"%@: ( %.0f, %.0f )",NSStringFromSelector(@selector(contentSize)),scrollView.contentSize.width,scrollView.contentSize.height];
    }
    
    if (CGAffineTransformEqualToTransform(self.transform, CGAffineTransformIdentity) == false)
    {
        [debugInfo appendFormat:@"%@: %@",NSStringFromSelector(@selector(transform)),NSStringFromCGAffineTransform(self.transform)];
    }
    
    return debugInfo;
}

-(BOOL)isSearchBarTextField
{
    return ([self isKindOfClass:UISearchBarTextFieldClass] || [self isKindOfClass:[UISearchBar class]]);
}

-(BOOL)isAlertViewTextField
{
    return ([self isKindOfClass:UIAlertSheetTextFieldClass] || [self isKindOfClass:UIAlertSheetTextFieldClass_iOS8]);
}

@end


@implementation NSObject (IQ_Logging)

-(NSString *)_IQDescription
{
    return [NSString stringWithFormat:@"<%@ %p>",NSStringFromClass([self class]),self];
}

@end
@implementation UIView (IQ_UIView_Frame)

-(CGFloat)x         {   return CGRectGetMinX(self.frame);   }
-(CGFloat)y         {   return CGRectGetMinY(self.frame);   }
-(CGFloat)width     {   return CGRectGetWidth(self.frame);  }
-(CGFloat)height    {   return CGRectGetHeight(self.frame); }
-(CGPoint)origin    {   return self.frame.origin;           }
-(CGSize)size       {   return self.frame.size;             }
-(CGFloat)left      {   return CGRectGetMinX(self.frame);   }
-(CGFloat)right     {   return CGRectGetMaxX(self.frame);   }
-(CGFloat)top       {   return CGRectGetMinY(self.frame);   }
-(CGFloat)bottom    {   return CGRectGetMaxY(self.frame);   }
-(CGFloat)centerX   {   return self.center.x;               }
-(CGFloat)centerY   {   return self.center.y;               }
-(CGPoint)boundsCenter  {   return CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));   };

-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    frame.size.width = MAX(self.right-left, 0);
    self.frame = frame;
}

-(void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.size.width = MAX(right-self.left, 0);
    self.frame = frame;
}

-(void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    frame.size.height = MAX(self.bottom-top, 0);
    self.frame = frame;
}

-(void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.size.height = MAX(bottom-self.top, 0);
    self.frame = frame;
}

-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}


@end
