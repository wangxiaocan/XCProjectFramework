//
//  LzxProgressView.h
//  LZX_Reader
//
//  Created by 王文科 on 2018/10/12.
//  Copyright © 2018 xiaocan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** progress view */
@interface LzxProgressView : UIView

@property (nonatomic, copy) NSString    *lAlertString;

- (void)showProgressView;

- (void)hiddenProgressView;

+ (instancetype)showProgressViewInView:(nonnull UIView *)toView;

+ (void)hiddenProgressViewFromView:(nonnull UIView *)fromView;

@end

NS_ASSUME_NONNULL_END
