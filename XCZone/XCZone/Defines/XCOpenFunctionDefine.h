//
//  XCOpenFunctionDefine.h
//  XCZone
//
//  Created by 王文科 on 2018/11/8.
//  Copyright © 2018 xiaocan. All rights reserved.
//

#ifndef XCOpenFunctionDefine_h
#define XCOpenFunctionDefine_h



#define XC_WEAK_SELF(s)        __weak typeof(s) weakSelf = s;

#define XC_RGB_A(r,g,b,a)     [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]

#define XC_RGB_COLOR(c,a)   [UIColor colorWithRed:c / 255.0 green:c / 255.0 blue:c / 255.0 alpha:a]

#define XC_S_FONT(f)      [UIFont systemFontOfSize:f]

#define XC_B_FONT(f)      [UIFont boldSystemFontOfSize:f]


#ifdef DEBUG
    #if XC_OPEN_NSLOG
        #define XC_LOG(...)    NSLog(__VA_ARGS__);
    #else
        #define XC_LOG(fmt...);
    #endif
#else
    #define XC_LOG(fmt...);
#endif


//控制器方法
#define XC_PUSH_CONTROLLER(control,toControl,animate) [control.navigationController pushViewController:toControl animated:animate]

#define XC_PRESENT_CONTROLLER(control,toController,animate,block)  [control presentViewController:toController animated:animate completion:block]

#define XC_POP_OR_DISMIS_CONTROLLER(controller,animate,block)  ({\
    if (controller.navigationController) {\
        [controller.navigationController popViewControllerAnimated:animate];\
    }\
    if (controller.presentedViewController) {\
        [controller dismissViewControllerAnimated:animate completion:block];\
    }\
})

#define XC_POP_CONTROLLER(controller,animate) [controller.navigationController popViewControllerAnimated:animate]

#define XC_DISMIS_CONTROLLER(controller,animate,block)   [controller dismissViewControllerAnimated:animate completion:block]



//显示 alert message 信息
#define L_SHOW_ALERT_MESSAGE(str,viewOrController)           [LAlertMessageView showAlertMessage:str inControlOrView:viewOrController atPosition:LAlertMessageViewMiddle]
#define L_SHOW_ALERT_MESSAGE_BOTTOM(str,viewOrController)      [LAlertMessageView showAlertMessage:str inControlOrView:viewOrController atPosition:LAlertMessageViewBottom]
#define L_SHOW_ALERT_MESSAGE_TOP(str,viewOrController)         [LAlertMessageView showAlertMessage:str inControlOrView:viewOrController atPosition:LAlertMessageViewTop]


//判断字符串是否是空（只含有空格、换行）
#define IS_EMPTY_STRING(str)    ({\
    BOOL val = YES;\
    if (str && [str isKindOfClass:[NSString class]]) {\
        NSString *vStr = [str copy];\
        vStr = [vStr stringByReplacingOccurrencesOfString:@" " withString:@""];\
        vStr = [vStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];\
        vStr = [vStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];\
        if (vStr.length > 0) {\
            val = NO;\
        }\
    }\
    (val);\
})



//转成字符串
#define VAL_TO_STRING(val) ({\
    NSString *valStr = @"";\
    if (val != nil){\
        valStr = [NSString stringWithFormat:@"%@",val];\
    }\
    [valStr mutableCopy];\
})

//转成字符串
#define INTEGER_TO_STRING(val) ({\
    NSString *valStr = [NSString stringWithFormat:@"%ld",(long)val];\
    [valStr mutableCopy];\
})

/** 判断字符串是否是 0-9 纯数字 */
#define IS_NUMBER_STRING(string)    ({\
    BOOL val = NO;\
    if (string && [string isKindOfClass:[NSString class]]) {\
        NSString *parttern = @"^[0-9]*$";\
        NSError *error = nil;\
        NSRegularExpression *ex = [[NSRegularExpression alloc] initWithPattern:parttern options:NSRegularExpressionCaseInsensitive error:&error];\
        if (!error){\
            NSArray *result = [ex matchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];\
            if (result.count > 0) {\
                val = YES;\
            }\
        }\
    }\
    (val);\
})



#endif /* XCOpenFunctionDefine_h */
