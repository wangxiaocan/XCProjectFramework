//
//  XCDeviceManager.m
//  XCZone
//
//  Created by 王文科 on 2018/11/8.
//  Copyright © 2018 xiaocan. All rights reserved.
//

#import "XCDeviceManager.h"

@interface XCDeviceManager()

@property (nonatomic, assign, readwrite) UIEdgeInsets screenEdgeInsets;

@property (nonatomic, assign, readwrite) CGFloat     navContentHeight;
@property (nonatomic, assign, readwrite) CGFloat     bottomSafeHeight;
@property (nonatomic, assign, readwrite) CGFloat     bottomToolHeight;
@property (nonatomic, assign, readwrite) CGFloat     bottomToolContentHegiht;

@end

@implementation XCDeviceManager

+ (instancetype)shareInstance{
    static XCDeviceManager  *deviceManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        deviceManager = [[XCDeviceManager alloc] init];
    });
    return deviceManager;
}

+ (UINavigationController *)mainNavigationController{
    [XCAppManager openNetworkMonitor];
    LzxMainViewController   *mainControl = [[LzxMainViewController alloc] init];
    LzxMainNavigationController *navigationController = [[LzxMainNavigationController alloc] initWithRootViewController:mainControl];
    navigationController.navigationBarHidden = YES;
    return navigationController;
}


- (UIEdgeInsets)screenEdgeInsets{
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        insets = [UIApplication sharedApplication].keyWindow.safeAreaInsets;
    } else {
        // Fallback on earlier versions
    }
    return insets;
}

- (CGFloat)navHeight{
    if (self.screenEdgeInsets.top == 0) {
        return self.navContentHeight + 20.0;
    }
    return self.navContentHeight + self.screenEdgeInsets.top;
}

- (CGFloat)navContentHeight{
    return 44.0;
}

- (CGFloat)bottomSafeHeight{
    return self.screenEdgeInsets.bottom;
}

- (CGFloat)bottomToolHeight{
    return self.bottomToolContentHegiht + self.screenEdgeInsets.bottom;
}

- (CGFloat)bottomToolContentHegiht{
    return 60.0;
}

- (CGFloat)statusBarHeight{
    if (self.screenEdgeInsets.top > 0) {
        return self.screenEdgeInsets.top;
    }
    return 20.0;
}




@end
