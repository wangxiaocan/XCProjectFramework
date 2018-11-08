//
//  LAlertMessageView.m
//  LZX_Reader
//
//  Created by 王文科 on 2018/10/17.
//  Copyright © 2018 xiaocan. All rights reserved.
//

#import "LAlertMessageView.h"

@interface LAlertMessageView()

//@property (nonatomic, strong) UIView    *lAlertBgView;
@property (nonatomic, strong) UILabel   *lAlertLabel;

@end

@implementation LAlertMessageView

- (instancetype)initWithString:(nonnull NSString *)string{
    self = [super init];
    if (self) {
        self.alpha = 0;
        
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 8.0;
        
        self.backgroundColor = XC_RGB_COLOR(0, 0.8);
        
        _lAlertLabel = [[UILabel alloc] init];
        _lAlertLabel.text = string;
        _lAlertLabel.numberOfLines = 0;
        _lAlertLabel.textAlignment = NSTextAlignmentCenter;
        _lAlertLabel.textColor = [UIColor whiteColor];
        _lAlertLabel.font = XC_S_FONT(14);
        [self addSubview:_lAlertLabel];
        [_lAlertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(10, 15, 10, 15));
        }];
    }
    return self;
}

+ (void)showAlertMessage:(NSString *)alertMessage{
    if (!IS_EMPTY_STRING(alertMessage)) {
        [self showAlertMessage:alertMessage inView:[UIApplication sharedApplication].keyWindow atPosition:LAlertMessageViewMiddle];
    }
}

+ (void)showAlertMessage:(NSString *)alertMessage atPosition:(LAlertMessageViewPosition)position{
    if (!IS_EMPTY_STRING(alertMessage)) {
        [self showAlertMessage:alertMessage inView:[UIApplication sharedApplication].keyWindow atPosition:position];
    }
}

+ (void)showAlertMessage:(NSString *)alertMessage inControlOrView:(id)col atPosition:(LAlertMessageViewPosition)position{
    if (!IS_EMPTY_STRING(alertMessage)) {
        if (col == nil) {
            if ([UIApplication sharedApplication].keyWindow) {
                [self showAlertMessage:alertMessage inView:[UIApplication sharedApplication].keyWindow atPosition:position];
            }
        }else if ([col isKindOfClass:[UIViewController class]]) {
            [self showAlertMessage:alertMessage inController:col atPosition:position];
        }else if ([col isKindOfClass:[UIView class]]) {
            [self showAlertMessage:alertMessage inView:col atPosition:position];
        }
    }
}

+ (void)showAlertMessage:(NSString *)alertMessage inController:(nonnull UIViewController *)controller atPosition:(LAlertMessageViewPosition)position{
    if (!IS_EMPTY_STRING(alertMessage) && controller != nil) {
        [self showAlertMessage:alertMessage inView:controller.view atPosition:position];
    }
}

+ (void)showAlertMessage:(NSString *)alertMessage inView:(nonnull UIView *)view atPosition:(LAlertMessageViewPosition)position{
    if (!IS_EMPTY_STRING(alertMessage) && view != nil) {
        for (UIView *vi in [view subviews]) {
            if ([vi isKindOfClass:[LAlertMessageView class]]) {
                [vi removeFromSuperview];
            }
        }
        LAlertMessageView *alertView = [[LAlertMessageView alloc] initWithString:alertMessage];
        [view addSubview:alertView];
        [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (position == LAlertMessageViewTop) {
                make.centerX.equalTo(view.mas_centerX);
                make.top.equalTo(view.mas_top).offset(XC_NAV_HEIGHT + 10.0);
            }else if (position == LAlertMessageViewBottom) {
                make.centerX.equalTo(view.mas_centerX);
                make.bottom.equalTo(view.mas_bottom).offset(-(XC_TOOL_HEIGHT + 30.0));
            }else{
                make.center.equalTo(alertView.superview);
            }
            make.width.lessThanOrEqualTo(alertView.superview).multipliedBy(0.8);
            make.width.mas_greaterThanOrEqualTo(80.0);
        }];
        [alertView showAlertView];
    }
}

- (void)showAlertView{
    self.alpha = 0.8;
    [self performSelector:@selector(hiddenAlertView) withObject:nil afterDelay:0.5];
}

- (void)hiddenAlertView{
    [UIView animateWithDuration:0.8 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

@end
