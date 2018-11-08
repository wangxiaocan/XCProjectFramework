//
//  XCDeviceManager.h
//  XCZone
//
//  Created by 王文科 on 2018/11/8.
//  Copyright © 2018 xiaocan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCDeviceManager : NSObject

+ (instancetype)shareInstance;

+ (UINavigationController *)mainNavigationController;

@property (nonatomic, assign, readonly) UIEdgeInsets screenEdgeInsets;

@property (nonatomic, assign, readonly) CGFloat      statusBarHeight;
@property (nonatomic, assign, readonly) CGFloat      navHeight;
@property (nonatomic, assign, readonly) CGFloat      navContentHeight;
@property (nonatomic, assign, readonly) CGFloat      bottomSafeHeight;
@property (nonatomic, assign, readonly) CGFloat      bottomToolHeight;
@property (nonatomic, assign, readonly) CGFloat      bottomToolContentHegiht;

@end

NS_ASSUME_NONNULL_END
