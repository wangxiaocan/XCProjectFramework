//
//  LzxTolBarView.h
//  LZX_Reader
//
//  Created by 王文科 on 2018/9/19.
//  Copyright © 2018年 xiaocan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LzxTolBarButton.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LzxTolBarViewDelegate;

@interface LzxTolBarView : UIView

@property (nonatomic, weak) id<LzxTolBarViewDelegate> lzxDelegate;


- (void)moveToTolButton:(nullable NSString *)type;

@end


@protocol LzxTolBarViewDelegate <NSObject>

@optional
- (void)lzxTolBarView:(LzxTolBarView *)tolBarView clickButton:(LzxTolBarButton *)button;

@end

NS_ASSUME_NONNULL_END
