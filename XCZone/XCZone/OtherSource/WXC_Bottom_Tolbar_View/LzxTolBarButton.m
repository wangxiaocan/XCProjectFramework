//
//  LzxTolBarButton.m
//  LZX_Reader
//
//  Created by 王文科 on 2018/9/19.
//  Copyright © 2018年 xiaocan. All rights reserved.
//

#import "LzxTolBarButton.h"

@implementation LzxTolBarButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lzxTitleNormalColor = XC_RGB_COLOR(138, 1.0);
        _lzxTitleSelectedColor = XC_RGB_A(253, 151, 39, 1.0);
        
        _lzxBtnImageView = [[UIImageView alloc] init];
        [self insertSubview:_lzxBtnImageView atIndex:0];
        _lzxBtnImageView.tintColor = _lzxTitleSelectedColor;
        _lzxBtnImageView.userInteractionEnabled = NO;
        
        _lzxBtnTitleLabel = [[UILabel alloc] init];
        _lzxBtnTitleLabel.font = [UIFont systemFontOfSize:13.0];
        _lzxBtnTitleLabel.textAlignment = NSTextAlignmentCenter;
        _lzxBtnTitleLabel.textColor = _lzxTitleNormalColor;
        [self insertSubview:_lzxBtnTitleLabel atIndex:0];
        
        [_lzxBtnImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).offset(7.0);
            make.width.and.height.mas_equalTo(23.0);
        }];
        [_lzxBtnTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(2.0);
            make.right.equalTo(self.mas_right).offset(-2.0);
            make.bottom.equalTo(self.mas_bottom).offset(-4.0);
            make.width.mas_equalTo(XC_DEVICE_WIDTH / 5.0 - 5.0);
        }];
        
    }
    return self;
}

- (void)setLzxTitleNormalColor:(UIColor *)lzxTitleNormalColor{
    _lzxTitleNormalColor = lzxTitleNormalColor;
    if (![self isSelected]) {
        _lzxBtnTitleLabel.textColor = _lzxTitleNormalColor;
    }
}

- (void)setLzxTitleSelectedColor:(UIColor *)lzxTitleSelectedColor{
    _lzxTitleSelectedColor = lzxTitleSelectedColor;
    if ([self isSelected]) {
        _lzxBtnTitleLabel.textColor = _lzxTitleSelectedColor;
    }
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    _lzxBtnImageView.highlighted = selected;
    if (selected) {
        _lzxBtnTitleLabel.textColor = _lzxTitleSelectedColor;
    }else{
        _lzxBtnTitleLabel.textColor = _lzxTitleNormalColor;
    }
    if (![self isSelected]) {
        _lzxBtnImageView.image = _lzxNormalImage;
    } else {
        _lzxBtnImageView.image = _lzxSelectedImage;
    }
}

- (void)setLzxNormalImage:(UIImage *)lzxNormalImage{
    _lzxNormalImage = lzxNormalImage;
    if (![self isSelected]) {
        _lzxBtnImageView.image = _lzxNormalImage;
    }
}

- (void)setLzxSelectedImage:(UIImage *)lzxSelectedImage{
    _lzxSelectedImage = lzxSelectedImage;
    if ([self isSelected]) {
        _lzxBtnImageView.image = _lzxSelectedImage;
    }
}



@end
