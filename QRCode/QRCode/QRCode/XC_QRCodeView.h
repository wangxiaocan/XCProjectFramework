//
//  XC_QRCodeView.h
//  QRCode
//
//  Created by 王文科 on 2019/5/29.
//  Copyright © 2019 xiaocan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN const CGFloat SCAN_WIDTH;
UIKIT_EXTERN const CGFloat SCAN_HEIGHT;


@protocol XC_QRCodeViewDelegate <NSObject>

@optional
- (void)qrScanViewDidOutputMetadata:(NSString *)string;

@end

@interface XC_QRCodeView : UIView


@property (nonatomic, weak) id<XC_QRCodeViewDelegate> delegate;

- (instancetype)initQRScanDelegate:(id<XC_QRCodeViewDelegate>)delegate withFrame:(CGRect)frame;

- (void)startSession;

- (void)stopSession;


@end

NS_ASSUME_NONNULL_END
