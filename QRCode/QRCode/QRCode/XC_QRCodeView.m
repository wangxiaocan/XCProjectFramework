//
//  XC_QRCodeView.m
//  QRCode
//
//  Created by 王文科 on 2019/5/29.
//  Copyright © 2019 xiaocan. All rights reserved.
//

#import "XC_QRCodeView.h"
#import <AVFoundation/AVFoundation.h>
#import "XC_ScanView.h"
#import <AssetsLibrary/AssetsLibrary.h>

const CGFloat SCAN_WIDTH = 240.0f;
const CGFloat SCAN_HEIGHT = 240.0f;


@interface XC_QRCodeView()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession          *session;
@property (nonatomic, strong) AVCaptureMetadataOutput   *metadataOutput;


@property (nonatomic, strong) XC_ScanView               *scanView;
@property (nonatomic, strong) UILabel                   *alertLabel;

@end

@implementation XC_QRCodeView

+ (Class)layerClass{
    return [AVCaptureVideoPreviewLayer class];
}

- (instancetype)initQRScanDelegate:(id<XC_QRCodeViewDelegate>)delegate withFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.delegate = delegate;
        
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (status == AVAuthorizationStatusDenied) {
            [self initDeniedView];
            return self;
        }
        
        [self initSession];
        [self initScanAnimateView];
        
        
        [self layoutSubviews];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (_metadataOutput) {
        // set scan avalible rect
        CGFloat width = CGRectGetWidth(self.frame);
        CGFloat height = CGRectGetHeight(self.frame);
        CGRect scanFrame =  CGRectMake((height / 2.0 - SCAN_HEIGHT / 2.0) / height , (width / 2.0 - SCAN_WIDTH / 2.0) / width, SCAN_HEIGHT / height, SCAN_WIDTH / width);
        [_metadataOutput setRectOfInterest:scanFrame];
    }
}

//session
- (void)initSession{
    self.backgroundColor = [UIColor blackColor];
    
    _session = [[AVCaptureSession alloc] init];
    
    //create video input
    NSError *error;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    if (!videoInput) {
        NSLog(@"create input error:%@",error);
    }
    
    //add video input to session
    if ([_session canAddInput:videoInput]) {
        [_session addInput:videoInput];
    }else{
        NSLog(@"can't add video input");
    }

    //add metadata output to session
    _metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    if ([_session canAddOutput:_metadataOutput]) {
        [_session addOutput:_metadataOutput];
        [_metadataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code]];
        [_metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    }else{
        NSLog(@"can't add metadata output");
    }
    
    //show preview
    [((AVCaptureVideoPreviewLayer *)self.layer) setSession:_session];
}

//scan animate view
- (void)initScanAnimateView{
    _scanView = [[XC_ScanView alloc] init];
    _scanView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_scanView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_scanView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_scanView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_scanView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_scanView)]];
}

- (void)initDeniedView{
    _alertLabel = [[UILabel alloc] init];
    _alertLabel.numberOfLines = 0;
    _alertLabel.font = [UIFont systemFontOfSize:16];
    _alertLabel.textColor = [UIColor lightGrayColor];
    _alertLabel.textAlignment = NSTextAlignmentCenter;
    _alertLabel.text = @"您已拒绝此APP使用设备摄像功能";
    [self addSubview:_alertLabel];
    _alertLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_alertLabel]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_alertLabel)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[_alertLabel]-60-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_alertLabel)]];
}


- (void)startSession{
    if (![self.session isRunning]) {
        [self.session startRunning];
        [_scanView  startAnimation];
    }
}

- (void)stopSession{
    if ([self.session isRunning]) {
        [self.session stopRunning];
        [_scanView stopAnimation];
    }
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (self.delegate && [self.delegate respondsToSelector:@selector(qrScanViewDidOutputMetadata:)]) {
        if (metadataObjects.count > 0) {
            if ([[metadataObjects firstObject] isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
                [self stopSession];
                AVMetadataMachineReadableCodeObject *qrCode = (AVMetadataMachineReadableCodeObject *)[metadataObjects firstObject];
                [self.delegate qrScanViewDidOutputMetadata:qrCode.stringValue];
            }
        }
    }
}

- (void)dealloc{
    if (_session && [_session isRunning]) {
        [_session stopRunning];
        _session = nil;
    }
}


@end
