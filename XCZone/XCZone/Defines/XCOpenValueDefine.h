//
//  XCOpenValueDefine.h
//  XCZone
//
//  Created by 王文科 on 2018/11/8.
//  Copyright © 2018 xiaocan. All rights reserved.
//

#ifndef XCOpenValueDefine_h
#define XCOpenValueDefine_h

//状态栏高度
#define XC_STAUTS_BAR_HEIGHT        ([XCDeviceManager shareInstance].statusBarHeight)

//导航栏高度
#define XC_NAV_HEIGHT               ([XCDeviceManager shareInstance].navHeight)

//导航栏内容高度
#define XC_NAV_CONTENT_HEIGHT       ([XCDeviceManager shareInstance].navContentHeight)

//工具栏高度
#define XC_TOOL_HEIGHT              ([XCDeviceManager shareInstance].bottomToolHeight)

//工具栏内容高度
#define XC_TOOL_CONTENT_HEIGHT      ([XCDeviceManager shareInstance].bottomToolContentHegiht)



//应用版本号
#define XC_APP_VERSION              [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"]

//系统版本号
#define XC_SYSTEM_VERSION           [[UIDevice currentDevice] systemVersion]

//屏幕宽度
#define XC_DEVICE_WIDTH             CGRectGetWidth([UIScreen mainScreen].bounds)

//屏幕高度
#define XC_DEVICE_HEIGHT            CGRectGetHeight([UIScreen mainScreen].bounds)

//是否有网络连接（需要提前开启 [XCAppManager openNetworkMonitor] 网络监听）
#define XC_HAVE_NET_CONNECT         [[XCAppManager shareInstance] netReachable]

//是否开启 LOG 输出 (0、关闭LOG输出，1、开启LOG输出)
#define XC_OPEN_NSLOG                1


#endif /* XCOpenValueDefine_h */
