//
//  LzxMainViewController.h
//  LZX_Reader
//
//  Created by 王文科 on 2018/9/19.
//  Copyright © 2018年 xiaocan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "../../Controllers/Home/Controller/XCHomeController.h"
#import "../../Controllers/Circle/Controller/XCCircleController.h"
#import "../../Controllers/Mine/Controller/XCMineController.h"

NS_ASSUME_NONNULL_BEGIN

//main view controller
@interface LzxMainViewController : UIViewController

@property (nonatomic, strong, readonly) XCHomeController        *homeControl;
@property (nonatomic, strong, readonly) XCCircleController      *circleControl;
@property (nonatomic, strong, readonly) XCMineController        *mineControl;


@property (nonatomic, weak, readonly) UIViewController          *lCurrentController;


- (void)moveToPageControl:(nullable NSString *)type;

@end

NS_ASSUME_NONNULL_END
