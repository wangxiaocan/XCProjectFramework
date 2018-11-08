//
//  XCAppManager.h
//  XCZone
//
//  Created by 王文科 on 2018/11/8.
//  Copyright © 2018 xiaocan. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString   *const XCAppNetworkTypeDidchangedNotication;

typedef NS_ENUM(NSUInteger, App_Net_Type) {
    App_Net_Type_NotReachable,
    App_Net_Type_WIFI,
    App_Net_Type_WWAN,
};


NS_ASSUME_NONNULL_BEGIN

@interface XCAppManager : NSObject

+ (instancetype)shareInstance;

+ (void)openNetworkMonitor;

+ (void)stopNetworkMonitor;


+ (App_Net_Type)currentNetType;
+ (App_Net_Type)lastNetType;

+ (BOOL)netReachable;

@property (nonatomic, readonly) BOOL    netReachable;
@property (nonatomic, readonly) App_Net_Type       lastNetType;
@property (nonatomic, readonly) App_Net_Type       currentNetType;

@end

NS_ASSUME_NONNULL_END
