//
//  ECTNetworkSpy.m
//  ECTECTIphone
//
//  Created by mac on 15/6/28.
//
//

#import "ECTNetworkSpy.h"
#include <arpa/inet.h>
#import "Reachability.h"

@interface ECTNetworkSpy ()
@property (nonatomic,strong)Reachability *reachability;
@end

@implementation ECTNetworkSpy

+ (ECTNetworkSpy*)sharedNetworkSpy
{
    static ECTNetworkSpy* _sharedNetworkSpy = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedNetworkSpy = [[ECTNetworkSpy alloc] init];
    });
    
    return _sharedNetworkSpy;
}


- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(networkChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
    }
    return self;
}

- (void) spyNetwork
{
    if (!self.reachability) {
        self.reachability = [Reachability reachabilityWithHostname:@"www.baidu.com"];
        
        _isReachableViaWiFi = [self.reachability isReachableViaWiFi];
        _isReachableViaWWAN = [self.reachability isReachableViaWWAN];
        _isReachable = [self.reachability isReachable];
        
        [self.reachability startNotifier];
    }
}

- (void)networkChanged:(NSNotification*)noti
{
    Reachability* reac = (Reachability*)noti.object;
    
    _isReachableViaWiFi = [reac isReachableViaWiFi];
    _isReachableViaWWAN = [reac isReachableViaWWAN];
    _isReachable = [reac isReachable];
    
    if ([self.spyDelegate respondsToSelector:@selector(didNetworkChangedReachable:viaWifi:)]) {
        [self.spyDelegate didNetworkChangedReachable:_isReachable viaWifi:_isReachableViaWiFi];
    }
}

- (BOOL)checkNetworkReachable
{
       Reachability *reachability = [Reachability reachabilityWithHostname:@"www.youtube.com"];
        _isReachable = [reachability isReachable];
        if (!_isReachable) {
            return NO;
        }
        return YES;
}

- (BOOL)checkWiFiReachable{
    
        Reachability *reachability = [Reachability reachabilityWithHostname:@"www.youtube.com"];
        _isReachableViaWiFi = [reachability isReachableViaWiFi];
        if (!_isReachableViaWiFi) {
            return NO;
        }
    return YES;

}

@end
