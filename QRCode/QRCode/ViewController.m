//
//  ViewController.m
//  QRCode
//
//  Created by 王文科 on 2019/5/29.
//  Copyright © 2019 xiaocan. All rights reserved.
//

#import "ViewController.h"
#import "XC_QRCodeView.h"

@interface ViewController ()

@property (nonatomic, strong) XC_QRCodeView *codeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _codeView = [[XC_QRCodeView alloc] initQRScanDelegate:self withFrame:self.view.bounds];
    [self.view addSubview:_codeView];
    [_codeView startSession];

}

- (void)qrScanViewDidOutputMetadata:(NSString *)string{
    __weak typeof(self) weakSelf = self;
    __weak NSString *weakString = string;
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"扫描结果" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *copy = [UIAlertAction actionWithTitle:@"Copy" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIPasteboard *pasboard = [UIPasteboard generalPasteboard];
        pasboard.string = weakString;
        [weakSelf.codeView startSession];
    }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.codeView startSession];
    }];
    [alertControl addAction:cancle];
    [alertControl addAction:copy];
    [self presentViewController:alertControl animated:YES completion:^{
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}


@end
