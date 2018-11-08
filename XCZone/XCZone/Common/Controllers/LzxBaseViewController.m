//
//  LzxBaseViewController.m
//  LZX_Reader
//
//  Created by 王文科 on 2018/9/19.
//  Copyright © 2018年 xiaocan. All rights reserved.
//

#import "LzxBaseViewController.h"

@interface LzxBaseViewController ()

@property (nonatomic, strong, readwrite) UIView        *lNavigationView;
@property (nonatomic, strong, readwrite) UIImageView   *lNavigationImageView;
@property (nonatomic, strong, readwrite) UIView        *lNavigationContentView;
@property (nonatomic, strong, readwrite) UIView        *lNavigationBottomLineView;

@property (nonatomic, strong, readwrite) UILabel       *lNavigationTitleLabel;
@property (nonatomic, strong, readwrite) UIButton      *lNavigationBackBtn;


@property (nonatomic, strong) UIImageView              *lNavigationBackImg;
@property (nonatomic, strong) UILabel                  *lNavigationBackTitleLabel;

@property (nonatomic, strong, readwrite) UIView        *lContentView;

@property (nonatomic, strong) LzxProgressView          *lProgressView;

@end

@implementation LzxBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.navigationController && self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.lBackViewHidden = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetNavigationLayout) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetNavigationLayout) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(currentNetworkDidChanged:) name:XCAppNetworkTypeDidchangedNotication object:nil];
}

- (void)setLBackViewHidden:(BOOL)lBackViewHidden{
    _lBackViewHidden = lBackViewHidden;
    self.lNavigationBackBtn.hidden = _lBackViewHidden;
    self.lNavigationBackImg.hidden = _lBackViewHidden;
    self.lNavigationBackTitleLabel.hidden = _lBackViewHidden;
}

- (LzxProgressView *)lProgressView{
    if (!_lProgressView) {
        _lProgressView = [[LzxProgressView alloc] init];
        [self.lContentView addSubview:_lProgressView];
        [_lProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.lContentView);
        }];
    }
    [self.lContentView bringSubviewToFront:_lProgressView];
    return _lProgressView;
}

- (UIView *)lContentView{
    if (!_lContentView) {
        _lContentView = [[UIView alloc] init];
        [self.view insertSubview:_lContentView atIndex:0];
        [_lContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    
    return _lContentView;
}

- (UIView *)lNavigationView{
    if (!_lNavigationView) {
        _lNavigationView = [[UIView alloc] init];
        _lNavigationView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_lNavigationView];
        [_lNavigationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.top.equalTo(self.view.mas_top);
            make.right.equalTo(self.view.mas_right);
            make.height.mas_equalTo(XC_NAV_HEIGHT);
        }];
        if (self.lNavigationBottomLineView) {
            
        }
    }
    return _lNavigationView;
}

- (UIImageView *)lNavigationImageView{
    if (!_lNavigationImageView) {
        _lNavigationImageView = [[UIImageView alloc] init];
        _lNavigationImageView.userInteractionEnabled = YES;
        [self.lNavigationView insertSubview:_lNavigationImageView atIndex:0];
        [_lNavigationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.lNavigationView);
        }];
    }
    return _lNavigationImageView;
}

- (UIView *)lNavigationContentView{
    if (!_lNavigationContentView) {
        _lNavigationContentView = [[UIView alloc] init];
        [self.lNavigationView addSubview:_lNavigationContentView];
        [_lNavigationContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.lNavigationView).insets(UIEdgeInsetsMake(XC_STAUTS_BAR_HEIGHT, 0, 0, 0));
        }];;
    }
    return _lNavigationContentView;
}

- (UIView *)lNavigationBottomLineView{
    if (!_lNavigationBottomLineView) {
        _lNavigationBottomLineView = [[UIView alloc] init];
        _lNavigationBottomLineView.backgroundColor = XC_RGB_COLOR(243, 1.0);
        [self.lNavigationContentView addSubview:_lNavigationBottomLineView];
        [_lNavigationBottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lNavigationContentView.mas_left);
            make.bottom.equalTo(self.lNavigationContentView.mas_bottom);
            make.right.equalTo(self.lNavigationContentView.mas_right);
            make.height.mas_equalTo(1.0);
        }];
    }
    return _lNavigationBottomLineView;
}

- (UILabel *)lNavigationTitleLabel{
    if (!_lNavigationTitleLabel) {
        _lNavigationTitleLabel = [[UILabel alloc] init];
        _lNavigationTitleLabel.textAlignment = NSTextAlignmentCenter;
        _lNavigationTitleLabel.font = XC_S_FONT(18.0);
        _lNavigationTitleLabel.textColor = [UIColor blackColor];
        [self.lNavigationContentView insertSubview:_lNavigationTitleLabel atIndex:0];
        [_lNavigationTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.lNavigationContentView);
            make.width.equalTo(self.lNavigationContentView.mas_width).multipliedBy(0.6);
        }];
    }
    return _lNavigationTitleLabel;
}

- (UIButton *)lNavigationBackBtn{
    if (!_lNavigationBackBtn) {
        _lNavigationBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.lNavigationContentView insertSubview:_lNavigationBackBtn atIndex:0];
        
        [_lNavigationBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lNavigationContentView.mas_left);
            make.top.equalTo(self.lNavigationContentView.mas_top);
            make.bottom.equalTo(self.lNavigationContentView.mas_bottom);
            make.right.equalTo(self.lNavigationBackTitleLabel.mas_right);
        }];
        
        [self.lNavigationBackImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lNavigationContentView.mas_left).offset(10.0);
            make.centerY.equalTo(self.lNavigationContentView.mas_centerY);
            make.width.mas_equalTo(24.0);
            make.height.mas_equalTo(24.0);
        }];
        [self.lNavigationBackTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lNavigationContentView.mas_centerY);
            make.left.equalTo(self.lNavigationBackImg.mas_right).offset(5.0);
        }];
        
        
        [_lNavigationBackBtn addTarget:self action:@selector(lNavigationBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lNavigationBackBtn;
}

- (UIImageView *)lNavigationBackImg{
    if (!_lNavigationBackImg) {
        _lNavigationBackImg = [[UIImageView alloc] init];
        _lNavigationBackImg.image = [UIImage imageNamed:@"D_Cn_Navigation_back_Gray"];
        [self.lNavigationContentView insertSubview:_lNavigationBackImg atIndex:0];
        if (self.lNavigationBackBtn) {
            
        }
    }
    return _lNavigationBackImg;
}

- (UILabel *)lNavigationBackTitleLabel{
    if (!_lNavigationBackTitleLabel) {
        _lNavigationBackTitleLabel = [[UILabel alloc] init];
        _lNavigationBackTitleLabel.textAlignment = NSTextAlignmentLeft;
        _lNavigationBackTitleLabel.font = XC_S_FONT(15.0);
        _lNavigationBackTitleLabel.text = @"";
        _lNavigationBackTitleLabel.textColor = [UIColor blackColor];
        [self.lNavigationContentView insertSubview:_lNavigationBackTitleLabel atIndex:0];
        if (self.lNavigationBackBtn) {
            
        }
    }
    return _lNavigationBackTitleLabel;
}

- (void)setLNavigaionTitle:(NSString *)lNavigaionTitle{
    _lNavigaionTitle = [lNavigaionTitle copy];
    self.lNavigationTitleLabel.text = _lNavigaionTitle;
}

- (void)setLNavigationBackTitle:(NSString *)lNavigationBackTitle{
    _lNavigationBackTitle = [lNavigationBackTitle copy];
    self.lNavigationBackTitleLabel.text = _lNavigationBackTitle;
}

- (void)setNavigationBackBtnTitleFont:(UIFont *)font andTitleColor:(UIColor *)color{
    if (font) {
        self.lNavigationTitleLabel.font = font;
    }
    if (color) {
        self.lNavigationTitleLabel.textColor = color;
    }
}

- (void)setNavitaionTitleFont:(UIFont *)font andTitleColor:(UIColor *)color{
    self.lNavigationTitleLabel.font = font;
    self.lNavigationTitleLabel.textColor = color;
}

- (void)setNavigationBackBtnImage:(UIImage *)img{
    self.lNavigationBackImg.image = img;
}

- (void)setNavigationBackBtnImageString:(NSString *)img{
    self.lNavigationBackImg.image = [UIImage imageNamed:img];
}

- (void)resetNavigationLayout{
    if (_lNavigationView) {
        [_lNavigationView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.top.equalTo(self.view.mas_top);
            make.right.equalTo(self.view.mas_right);
            make.height.mas_equalTo(XC_NAV_HEIGHT);
        }];
    }
    if (_lNavigationContentView) {
        [_lNavigationContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.lNavigationView).insets(UIEdgeInsetsMake(XC_STAUTS_BAR_HEIGHT, 0, 0, 0));
        }];;
    }
}

- (void)lNavigationBackBtnClicked:(UIButton *)sender{
    XC_POP_OR_DISMIS_CONTROLLER(self, YES, nil);
}

- (void)showHUDProgress:(BOOL)animate{
    [self.lProgressView showProgressView];
}

- (void)hiddenHUDProgress:(BOOL)animate{
    [self.lProgressView hiddenProgressView];
}

- (BOOL)netReachable{
    return [XCAppManager shareInstance].netReachable;
}

- (void)currentNetworkDidChanged:(NSNotification *)notifi{
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (_lProgressView) {
        [_lProgressView hiddenProgressView];
    }
}

@end
