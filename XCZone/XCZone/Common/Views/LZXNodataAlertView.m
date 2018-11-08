//
//  LZXNodataAlertView.m
//  LZX_Reader
//
//  Created by 王文科 on 2018/10/12.
//  Copyright © 2018 xiaocan. All rights reserved.
//

#import "LZXNodataAlertView.h"



@interface LZXNodataAlertView()

@property (nonatomic, strong) UIView    *lContentView;

@property (nonatomic, copy)    LZXNodataAlertViewBlock myBlock;

@end

@implementation LZXNodataAlertView

- (instancetype)initWithTouchBlock:(LZXNodataAlertViewBlock)block{
    self = [super init];
    if (self) {
        self.myBlock = block;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = XC_RGB_COLOR(237, 1.0);
        
        _lContentView = [[UIView alloc] init];
        _lContentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_lContentView];
        
        _lAlertImageView = [[UIImageView alloc] init];
        _lAlertImageView.userInteractionEnabled = YES;
        _lAlertImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.lContentView addSubview:_lAlertImageView];
        
        _lAlertTitleLabel = [[UILabel alloc] init];
        _lAlertTitleLabel.font = XC_S_FONT(15.0);
        _lAlertTitleLabel.textAlignment = NSTextAlignmentCenter;
        _lAlertTitleLabel.textColor = XC_RGB_COLOR(187, 1.0);
        _lAlertTitleLabel.numberOfLines = 0;
        _lAlertTitleLabel.text = @"还没有数据哦~";
        [self.lContentView addSubview:_lAlertTitleLabel];

        [_lContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20.0);
            make.right.equalTo(self.mas_right).offset(-20.0);
            make.centerY.equalTo(self.mas_centerY);
        }];
        [_lAlertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lContentView.mas_top);
            make.centerX.equalTo(self.lContentView.mas_centerX);
            make.bottom.equalTo(self.lAlertTitleLabel.mas_top);
            make.height.mas_equalTo(0);
        }];
        [_lAlertTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lContentView.mas_left);
            make.right.equalTo(self.lContentView.mas_right);
            make.bottom.equalTo(self.lContentView.mas_bottom);
        }];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.myBlock) {
        self.myBlock(YES);
    }
}

@end
