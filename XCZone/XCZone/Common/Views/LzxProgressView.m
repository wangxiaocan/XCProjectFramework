//
//  LzxProgressView.m
//  LZX_Reader
//
//  Created by 王文科 on 2018/10/12.
//  Copyright © 2018 xiaocan. All rights reserved.
//

#import "LzxProgressView.h"

@interface LzxProgressView()

@property (nonatomic, strong) UIView        *lContentView;
@property (nonatomic, strong) UIImageView   *lProgressImgView;
@property (nonatomic, strong) UILabel       *lAlertLabel;

@property (nonatomic, strong) NSTimer       *progressTimer;

@property (nonatomic, assign) double        lRotate;

@end

@implementation LzxProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.hidden = YES;
        
        _lContentView = [[UIView alloc] init];
        _lContentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_lContentView];
        
        _lProgressImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"D_Cn_Progress"]];
        [_lContentView addSubview:_lProgressImgView];
        
        _lAlertLabel = [[UILabel alloc] init];
        _lAlertLabel.font = XC_S_FONT(14);
        _lAlertLabel.textAlignment = NSTextAlignmentCenter;
        _lAlertLabel.textColor = XC_RGB_COLOR(187, 1.0);
        _lAlertLabel.numberOfLines = 0;
        [_lContentView addSubview:_lAlertLabel];
        
        [_lContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(20.0);
            make.right.equalTo(self.mas_right).offset(-20.0);
        }];
        [_lProgressImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(30.0);
            make.top.equalTo(self.lContentView.mas_top);
            make.centerX.equalTo(self.lContentView.mas_centerX);
        }];
        [_lAlertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lContentView.mas_left);
            make.right.equalTo(self.lContentView.mas_right);
            make.bottom.equalTo(self.lContentView.mas_bottom);
            make.top.equalTo(self.lProgressImgView.mas_bottom);
            make.height.mas_equalTo(0);
        }];
        
    }
    return self;
}

- (void)setLAlertString:(NSString *)lAlertString{
    _lAlertString = [lAlertString copy];
    if (IS_EMPTY_STRING(_lAlertString)) {
        self.lAlertLabel.text = @"";
        [_lAlertLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lContentView.mas_left);
            make.right.equalTo(self.lContentView.mas_right);
            make.bottom.equalTo(self.lContentView.mas_bottom);
            make.top.equalTo(self.lProgressImgView.mas_bottom);
            make.height.mas_equalTo(0);
        }];
    }else{
        self.lAlertLabel.text = _lAlertString;
        [_lAlertLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lContentView.mas_left);
            make.right.equalTo(self.lContentView.mas_right);
            make.bottom.equalTo(self.lContentView.mas_bottom);
            make.top.equalTo(self.lProgressImgView.mas_bottom).offset(5.0);
        }];
    }
    
    
}

- (void)showProgressView{
    if (!_progressTimer) {
        _progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(startProgressAnimations) userInfo:nil repeats:YES];
    }
    self.hidden = NO;
}

- (void)hiddenProgressView{
    if (_progressTimer) {
        [_progressTimer invalidate];
        _progressTimer = nil;
    }
    _lRotate = 0;
    _lProgressImgView.transform = CGAffineTransformIdentity;
    self.hidden = YES;
}

- (void)startProgressAnimations{
    _lRotate += M_PI * 0.1;
    _lProgressImgView.transform = CGAffineTransformMakeRotation(_lRotate);
}




+ (instancetype)showProgressViewInView:(nonnull UIView *)toView{
    LzxProgressView *progressView = [[LzxProgressView alloc] initWithFrame:toView.bounds];
    [toView addSubview:progressView];
    [progressView showProgressView];
    return progressView;
}

+ (void)hiddenProgressViewFromView:(nonnull UIView *)fromView{
    NSArray *views = [fromView subviews];
    for (LzxProgressView *view in views) {
        if ([view isKindOfClass:[LzxProgressView class]]) {
            [view hiddenProgressView];
            [view removeFromSuperview];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)dealloc{
    if (_progressTimer) {
        [_progressTimer invalidate];
        _progressTimer = nil;
    }
}

@end
