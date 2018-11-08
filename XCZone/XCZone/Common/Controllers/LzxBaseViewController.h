//
//  LzxBaseViewController.h
//  LZX_Reader
//
//  Created by 王文科 on 2018/9/19.
//  Copyright © 2018年 xiaocan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LzxBaseViewController : UIViewController

@property (nonatomic, strong, readonly) UIView        *lNavigationView;
@property (nonatomic, strong, readonly) UIImageView   *lNavigationImageView;
@property (nonatomic, strong, readonly) UIView        *lNavigationContentView;
@property (nonatomic, strong, readonly) UIView        *lNavigationBottomLineView;
@property (nonatomic, strong, readonly) UILabel       *lNavigationTitleLabel;
@property (nonatomic, strong, readonly) UIButton      *lNavigationBackBtn;

@property (nonatomic, strong, readonly) UIView        *lContentView;


@property (nonatomic, copy) NSString    *lNavigaionTitle;
@property (nonatomic, copy) NSString    *lNavigationBackTitle;


@property (nonatomic, assign)           BOOL   lBackViewHidden;
@property (nonatomic, readonly)         BOOL   netReachable;



- (void)setNavigationBackBtnTitleFont:(UIFont *)font andTitleColor:(UIColor *)color;

- (void)setNavitaionTitleFont:(UIFont *)font andTitleColor:(UIColor *)color;

- (void)setNavigationBackBtnImage:(UIImage *)img;

- (void)setNavigationBackBtnImageString:(NSString *)img;

- (void)showHUDProgress:(BOOL)animate;

- (void)hiddenHUDProgress:(BOOL)animate;


- (void)currentNetworkDidChanged:(NSNotification *)notifi;


@end

NS_ASSUME_NONNULL_END
