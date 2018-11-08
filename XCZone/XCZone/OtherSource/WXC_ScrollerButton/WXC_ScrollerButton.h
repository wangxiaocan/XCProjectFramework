//
//  WXC_ScrollerButton.h
//  lzxReader
//
//  Created by 王文科 on 2018/9/17.
//  Copyright © 2018年 xiaocan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WXC_ScrollerButtonDelegate;

@interface WXC_ScrollerButton : UIView

- (instancetype)initWithButtonTitles:(NSArray<NSString *> *)buttonTitles;

@property (nonatomic, weak)   id<WXC_ScrollerButtonDelegate> wxcScrollerButtonDelegate;

@property (nonatomic, assign) BOOL      showTitleBottomLine;/**< default is true */

@property (nonatomic, strong) UIColor   *btnNormalCorlor;   /**< btn title normal color */
@property (nonatomic, strong) UIColor   *btnSelectedColor;  /**< btn title selected color */

@property (nonatomic, strong) UIFont    *btnNormalFont;     /**< btn title normal font */
@property (nonatomic, strong) UIFont    *btnSelectedFont;   /**< btn title selected font */

/** current selected title index */
@property (nonatomic, assign, readonly) NSInteger   currentIndex;

/** resume button titles and current selected index */
- (void)resumeButtonTitles:(NSArray<NSString *> *)buttonTitles;

/** auto scroller to designated index */
- (void)scrollerToIndex:(NSInteger)index;

@end



@protocol WXC_ScrollerButtonDelegate<NSObject>

@optional
- (void)wxc_scrollerButton:(WXC_ScrollerButton *)scrollerView didScrollerToIndex:(NSInteger)index;


@end

