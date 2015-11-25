//
//  ECTNetworkSpy.h
//  ECTECTIphone
//
//  Created by mac on 15/6/28.
//
//

#import <Foundation/Foundation.h>
@protocol RCNetworkSpyDelegate;
@interface ECTNetworkSpy : NSObject

+ (ECTNetworkSpy*)sharedNetworkSpy;

@property (nonatomic, assign) BOOL isReachableViaWiFi;
@property (nonatomic, assign) BOOL isReachableViaWWAN;
@property (nonatomic, assign) BOOL isReachable;
@property (nonatomic, assign) id<RCNetworkSpyDelegate> spyDelegate;

- (void)spyNetwork;
- (BOOL)checkNetworkReachable;
- (BOOL)checkWiFiReachable;


@end

@protocol RCNetworkSpyDelegate <NSObject>

- (void)didNetworkChangedReachable:(BOOL)reachable viaWifi:(BOOL)viaWifi;
@end