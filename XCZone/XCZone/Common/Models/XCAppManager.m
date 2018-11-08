//
//  XCAppManager.m
//  XCZone
//
//  Created by 王文科 on 2018/11/8.
//  Copyright © 2018 xiaocan. All rights reserved.
//

#import "XCAppManager.h"
#import "Reachability.h"

NSString   *const XCAppNetworkTypeDidchangedNotication = @"XC_AppNetworkTypeDidchangedNotication";

@interface XCAppManager()

@property (nonatomic, strong) Reachability  *reachability;

@property (nonatomic, assign, readwrite) BOOL    netReachable;

@property (nonatomic, assign, readwrite) App_Net_Type       lastNetType;
@property (nonatomic, assign, readwrite) App_Net_Type       currentNetType;

@end

@implementation XCAppManager

+ (instancetype)shareInstance{
    static XCAppManager *appManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appManager = [[XCAppManager alloc] init];
        NetworkStatus status = [appManager.reachability currentReachabilityStatus];
        switch (status) {
            case ReachableViaWiFi:
                appManager.netReachable = YES;
                appManager.lastNetType = App_Net_Type_WIFI;
                appManager.currentNetType = App_Net_Type_WIFI;
                break;
            case ReachableViaWWAN:
                appManager.netReachable = YES;
                appManager.lastNetType = App_Net_Type_WWAN;
                appManager.currentNetType = App_Net_Type_WWAN;
                break;
            default:
                appManager.netReachable = NO;
                appManager.lastNetType = App_Net_Type_NotReachable;
                appManager.currentNetType = App_Net_Type_NotReachable;
                break;
        }
        [[NSNotificationCenter defaultCenter]addObserver:appManager selector:@selector(networkStateChange:) name:kReachabilityChangedNotification object:nil];
    });
    return appManager;
}

- (Reachability *)reachability{
    if (!_reachability) {
        _reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    }
    return _reachability;
}

+ (void)openNetworkMonitor{
    [[XCAppManager shareInstance].reachability startNotifier];
}

+ (void)stopNetworkMonitor{
    [[XCAppManager shareInstance].reachability stopNotifier];
}

- (void)networkStateChange:(NSNotification *)notifi{
    NetworkStatus status = [self.reachability currentReachabilityStatus];
    if (status == ReachableViaWiFi) {
        self.netReachable = YES;
        self.lastNetType = self.currentNetType;
        self.currentNetType = App_Net_Type_WIFI;
    }else if (status == ReachableViaWWAN) {
        self.netReachable = YES;
        self.lastNetType = self.currentNetType;
        self.currentNetType = App_Net_Type_WWAN;
    }else{
        self.netReachable = NO;
        self.lastNetType = self.currentNetType;
        self.currentNetType = App_Net_Type_NotReachable;
    }
    
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(postNetchangedNotification) object:self];
    [self performSelector:@selector(postNetchangedNotification) withObject:self afterDelay:0.25];
}

- (void)postNetchangedNotification{
    if (_lastNetType == App_Net_Type_NotReachable && _netReachable) {
        L_SHOW_ALERT_MESSAGE(@"网络已连接~", nil);
    }else if (!_netReachable) {
        L_SHOW_ALERT_MESSAGE(@"网络连接已断开~", nil);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:XCAppNetworkTypeDidchangedNotication object:self userInfo:nil];
}

+ (App_Net_Type)currentNetType{
    return [XCAppManager shareInstance].currentNetType;
}
+ (App_Net_Type)lastNetType{
    return [XCAppManager shareInstance].lastNetType;
}

+ (BOOL)netReachable{
    return [XCAppManager shareInstance].netReachable;
}


@end
