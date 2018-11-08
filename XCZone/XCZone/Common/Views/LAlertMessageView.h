//
//  LAlertMessageView.h
//  LZX_Reader
//
//  Created by 王文科 on 2018/10/17.
//  Copyright © 2018 xiaocan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, LAlertMessageViewPosition) {
    LAlertMessageViewTop,
    LAlertMessageViewMiddle,
    LAlertMessageViewBottom,
};

/** L_SHOW_ALERT_MESSAGE(str) */
@interface LAlertMessageView : UIView

+ (void)showAlertMessage:(NSString *)alertMessage;

+ (void)showAlertMessage:(NSString *)alertMessage atPosition:(LAlertMessageViewPosition)position;

+ (void)showAlertMessage:(NSString *)alertMessage inController:(nonnull UIViewController *)controller atPosition:(LAlertMessageViewPosition)position;

+ (void)showAlertMessage:(NSString *)alertMessage inView:(nonnull UIView *)view atPosition:(LAlertMessageViewPosition)position;

+ (void)showAlertMessage:(NSString *)alertMessage inControlOrView:(nullable id)col atPosition:(LAlertMessageViewPosition)position;


@end

NS_ASSUME_NONNULL_END
