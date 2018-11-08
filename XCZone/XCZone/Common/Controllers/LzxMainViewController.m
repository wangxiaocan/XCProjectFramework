//
//  LzxMainViewController.m
//  LZX_Reader
//
//  Created by 王文科 on 2018/9/19.
//  Copyright © 2018年 xiaocan. All rights reserved.
//

#import "LzxMainViewController.h"
#import "../../OtherSource/WXC_Bottom_Tolbar_View/LzxTolBarView.h"

@interface LzxMainViewController ()<LzxTolBarViewDelegate>

@property (nonatomic, strong) UIView    *lzxChildView;

@property (nonatomic, strong, readwrite) XCHomeController       *homeControl;
@property (nonatomic, strong, readwrite) XCCircleController     *circleControl;
@property (nonatomic, strong, readwrite) XCMineController       *mineControl;

@property (nonatomic, weak) UIViewController    *lCurrentController;


@property (nonatomic, strong) LzxTolBarView *bottomToolView;

@end

@implementation LzxMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _lzxChildView = [[UIView alloc]init];
    _lzxChildView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_lzxChildView];
    [_lzxChildView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _bottomToolView = [[LzxTolBarView alloc] init];
    _bottomToolView.lzxDelegate = self;
    _bottomToolView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomToolView];
    [_bottomToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(XC_TOOL_HEIGHT);
    }];
    
    
    _homeControl = [[XCHomeController alloc] init];
    _circleControl = [[XCCircleController alloc] init];
    _mineControl = [[XCMineController alloc] init];

    
    [self addChildViewController:_homeControl];
    [self addChildViewController:_circleControl];
    [self addChildViewController:_mineControl];
    [self addChildViewController:_mineControl];
    [_lzxChildView addSubview:_homeControl.view];
    _homeControl.view.frame = self.lzxChildView.bounds;
    _lCurrentController = _homeControl;
    
    
}


- (void)moveToPageControl:(nullable NSString *)type{
    [_bottomToolView moveToTolButton:type];
}



- (void)lzxTolBarView:(LzxTolBarView *)tolBarView clickButton:(LzxTolBarButton *)button{
    if (button.lzxBtnType) {
        XC_WEAK_SELF(self);
        if ([button.lzxBtnType isEqualToString:@"home"]) {
            if (_lCurrentController != _homeControl) {
                [self transitionFromViewController:_lCurrentController toViewController:_homeControl duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    
                } completion:^(BOOL finished) {
                    weakSelf.lCurrentController = weakSelf.homeControl;
                }];
            }
        }else if ([button.lzxBtnType isEqualToString:@"circle"]){
            if (_lCurrentController != _circleControl) {
                [self transitionFromViewController:_lCurrentController toViewController:_circleControl duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    
                } completion:^(BOOL finished) {
                    weakSelf.lCurrentController = weakSelf.circleControl;
                }];
            }
        }else if ([button.lzxBtnType isEqualToString:@"mine"]){
            if (_lCurrentController != _mineControl) {
                [self transitionFromViewController:_lCurrentController toViewController:_mineControl duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    
                } completion:^(BOOL finished) {
                    weakSelf.lCurrentController = weakSelf.mineControl;
                }];
            }
        }
    }
}







/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
