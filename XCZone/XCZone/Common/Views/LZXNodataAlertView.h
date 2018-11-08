//
//  LZXNodataAlertView.h
//  LZX_Reader
//
//  Created by 王文科 on 2018/10/12.
//  Copyright © 2018 xiaocan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^LZXNodataAlertViewBlock)(BOOL touched);

@interface LZXNodataAlertView : UIView

@property (nonatomic, strong, readonly) UIImageView     *lAlertImageView;
@property (nonatomic, strong, readonly) UILabel         *lAlertTitleLabel;

- (instancetype)initWithTouchBlock:(nullable LZXNodataAlertViewBlock)block;


@end

NS_ASSUME_NONNULL_END
