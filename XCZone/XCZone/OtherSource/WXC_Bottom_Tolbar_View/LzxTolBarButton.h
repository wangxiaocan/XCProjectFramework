//
//  LzxTolBarButton.h
//  LZX_Reader
//
//  Created by 王文科 on 2018/9/19.
//  Copyright © 2018年 xiaocan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LzxTolBarButton : UIButton

@property (nonatomic, copy)   NSString      *lzxBtnType;

@property (nonatomic, strong) UIImageView   *lzxBtnImageView;
@property (nonatomic, strong) UILabel       *lzxBtnTitleLabel;

@property (nonatomic, strong) UIColor       *lzxTitleNormalColor;
@property (nonatomic, strong) UIColor       *lzxTitleSelectedColor;

@property (nonatomic, strong) UIImage       *lzxNormalImage;
@property (nonatomic, strong) UIImage       *lzxSelectedImage;


@end

NS_ASSUME_NONNULL_END
