//
//  XC_ScanView.m
//  QRCode
//
//  Created by 王文科 on 2019/5/29.
//  Copyright © 2019 xiaocan. All rights reserved.
//

#import "XC_ScanView.h"
#import "XC_QRCodeView.h"


@interface XC_ScanView()

@property (nonatomic, strong) UIImageView   *scanImageView;
@property (nonatomic, strong) UIImageView   *lineImgView;

@end

@implementation XC_ScanView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self initImageViews];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (void) initImageViews{
    _scanImageView = [[UIImageView alloc] init];
    _scanImageView.image = [[UIImage imageNamed:@"saomiaokuang"] stretchableImageWithLeftCapWidth:60 topCapHeight:60];
    _scanImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_scanImageView];
    
    _lineImgView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"saomiaoine"] stretchableImageWithLeftCapWidth:50 topCapHeight:10]];
    _lineImgView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_lineImgView];
    [self addImageConstraints];
}

- (void)addImageConstraints{

    [self addConstraint:[NSLayoutConstraint constraintWithItem:_scanImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_scanImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_scanImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:SCAN_WIDTH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_scanImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:SCAN_HEIGHT]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineImgView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_scanImageView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineImgView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_scanImageView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineImgView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_scanImageView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineImgView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:5]];
    
}

- (void)drawRect:(CGRect)rect{
    
    CGRect scanFrame = CGRectMake(CGRectGetWidth(self.frame) / 2.0 - SCAN_WIDTH / 2.0, CGRectGetHeight(self.frame) / 2.0 - SCAN_HEIGHT / 2.0, SCAN_WIDTH, SCAN_HEIGHT);
    [[UIColor colorWithWhite:0 alpha:0.7] setFill];
    UIBezierPath *fullPath = [UIBezierPath bezierPathWithRect:self.bounds];
    UIBezierPath *centerPath = [UIBezierPath bezierPathWithRoundedRect:scanFrame cornerRadius:0];
    [fullPath appendPath:[centerPath bezierPathByReversingPath]];
    [fullPath fill];
    [self startAnimation];
}

- (void)startAnimation{
    CABasicAnimation *animation = [self basicAnimation];
    if (animation) {
        _lineImgView.layer.speed = 1.0f;
    }else{
        animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        animation.byValue = @(SCAN_HEIGHT - 5.0);
        animation.duration = 1.0;
        animation.repeatCount = CGFLOAT_MAX;
        animation.removedOnCompletion = NO;
        animation.cumulative = YES;
        animation.autoreverses = YES;
        [_lineImgView.layer addAnimation:animation forKey:@"line_animation"];
    }
}

- (void)stopAnimation{
    CABasicAnimation *animatioin = [self basicAnimation];
    if (animatioin) {
        _lineImgView.layer.speed = 0.0f;
    }
}

- (nullable CABasicAnimation *)basicAnimation{
    CABasicAnimation *animation = [_lineImgView.layer animationForKey:@"line_animation"];
    if (animation && [animation isKindOfClass:[CABasicAnimation class]]) {
        return animation;
    }
    return nil;
}

- (void)dealloc{
    [_lineImgView.layer removeAllAnimations];
}

@end
