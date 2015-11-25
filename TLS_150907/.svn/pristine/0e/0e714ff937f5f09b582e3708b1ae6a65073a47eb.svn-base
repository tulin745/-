//
//  Global.h
//  ECTECTIphone
//
//  Created by mac on 15/5/19.
//
//
#import "JXErrorInfo.h"

#ifndef ECTECTIphone_Global_h
#define ECTECTIphone_Global_h
#define TIMEOUT     30
#define Color_RGB(r,g,b)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// 判断是否为ios7
#define ios7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

#define mAvailableString(string) string==nil?@"":string

#define mApplicationDelegate ((MyAppDelegate *)[UIApplication sharedApplication].delegate)

#define WS(weakself) __weak __typeof(&*self)weakSelf = self

#define KeyWindow [UIApplication sharedApplication].keyWindow
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define IsIos7Later [CurrentSystemVersion floatValue] < 7.0 ? NO : YES
#define IsIos8Later [CurrentSystemVersion floatValue] < 8.0 ? NO : YES

#define GetFieldLevel(passguardtextfield) mAvailableString([[[passguardtextfield getInputLevel] objectAtIndex:0] stringValue])

// 1：简单  0：非简单
#define WeakOrStrongCode(passguardtextfield) mAvailableString([[[passguardtextfield getInputLevel] objectAtIndex:1] stringValue])


//ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

#define NIB_Load(ClassName) [[NSBundle mainBundle] loadNibNamed:ClassName owner:nil options:nil].firstObject

#define mHomeADPlaceholderImage [[UIImage alloc]imageWithColor:[UIColor whiteColor]]
#define mShufflingTime     @"ShufflingTime"//默认轮播图时间

#define HttpType_customers @"customers"


#ifdef DEBUG
# define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define NSLog(...)

#endif

#define ThemeColor UIColorFromRGB(0xDB0013)//红色

#define UserDefault_userInfo @"customerUserInfo"
#define cartList @"cartList"

#endif




