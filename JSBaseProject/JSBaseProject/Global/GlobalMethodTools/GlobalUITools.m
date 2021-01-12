//
//  GlobalUITools.m
//  AnpaiPrecision
//
//  Created by AnPai on 2018/10/11.
//  Copyright © 2018 AnPai. All rights reserved.
//

#import "GlobalUITools.h"

@interface GlobalUITools ()


@property (nonatomic, strong) MBProgressHUD *tmpHud;


@end

@implementation GlobalUITools

#pragma mark -- Controller
//获取当前控制器
+ (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
//    if ([rootVC isKindOfClass:[BaseTabbarViewController class]]) {
//        BaseTabbarViewController *baseTabC = (BaseTabbarViewController *)rootVC;
//        UIViewController *topViewController = baseTabC;//rootVC
//        if (topViewController.presentedViewController) {
//            topViewController = topViewController.presentedViewController;
//        } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController]) {
//            topViewController = [(UINavigationController *)topViewController topViewController];
//        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
//            UITabBarController *tab = (UITabBarController *)topViewController;
//            topViewController = tab.selectedViewController;
//        }
//        return topViewController;
//    }else
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        result = [[(UITabBarController *)rootVC selectedViewController] visibleViewController];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        result = [(UINavigationController *)rootVC visibleViewController];
    } else if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        result = [rootVC presentedViewController];
    } else {
        // 根视图为非导航类
        result = rootVC;
    }
    return result;

}

/**获取当前导航栏控制器 */
+ (UINavigationController *)getCurrentNav {
    UINavigationController *result = nil;
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        result =  [(UITabBarController *)rootVC  selectedViewController];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        result = (UINavigationController *)rootVC;
    }
    return result;
}


#pragma mark -- HUDShow
+ (MBProgressHUD *)instanceHUD {
    static MBProgressHUD *tmpHud = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        tmpHud = [[MBProgressHUD alloc]initWithView:[UIApplication sharedApplication].keyWindow ];
        [[UIApplication sharedApplication].keyWindow addSubview:tmpHud];
        
    });
    return tmpHud;
}

+ (void)showMessage:(NSString *)string withView:(UIView *)view {
    
    if (![GlobalMethodsTools Object_IsNotBlank:string]) {
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;    
    hud.label.text = string;
    hud.label.numberOfLines = 0;
    hud.label.textColor = [UIColor colorWithHex:0xffffff];
    hud.label.font = [UIFont systemFontOfSize:14.0];
    hud.bezelView.backgroundColor=[UIColor colorWithHex:0x333333];
    [view addSubview:hud];
    
    [hud hideAnimated:YES afterDelay:1.5];
}

+ (void)showAnimationMessage:(NSString *)string {
    MBProgressHUD *hud = [self instanceHUD];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.contentColor = [UIColor whiteColor];
    hud.label.text = string;
    hud.label.numberOfLines = 0;
    hud.label.textColor = [UIColor colorWithHex:0xffffff];
    hud.label.font = [UIFont systemFontOfSize:14.0];
    hud.bezelView.backgroundColor = [UIColor colorWithHex:0x333333];
    [hud showAnimated:YES];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:hud];
}

+ (void)hideAnimationMessage{
    MBProgressHUD *hud = [self instanceHUD];
    if (hud.hidden) {
        return;
    } else {
        [hud hideAnimated:YES];
    }
}

/**整个window显示信息 */
+ (void)showGlobalWindowMessage:(NSString *)string {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = string;
    hud.label.numberOfLines = 0;
    hud.label.textColor = [UIColor colorWithHex:0xffffff];
    hud.label.font = [UIFont systemFontOfSize:14.0];
    hud.bezelView.backgroundColor=[UIColor colorWithHex:0x333333];
    [hud hideAnimated:YES afterDelay:1.5];
    
}

/**根据时间 展示在整个window显示信息 */
+ (void)showGlobalWindowMessage:(NSString *)string afterDelay:(NSTimeInterval)delay {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = string;
    hud.label.numberOfLines = 0;
    hud.label.textColor = [UIColor colorWithHex:0xffffff];
    hud.label.font = [UIFont systemFontOfSize:14.0];
    hud.bezelView.backgroundColor=[UIColor colorWithHex:0x333333];
    [hud hideAnimated:YES afterDelay:delay];
    
}


/**针对单个view的菊花 */
+ (void)showSimpleHudMessage:(NSString *)message WithView:(UIView *)view {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.contentColor = [UIColor whiteColor];
        hud.label.text = message;
        hud.label.numberOfLines = 0;
        hud.label.textColor = [UIColor colorWithHex:0xffffff];
        hud.label.font = [UIFont systemFontOfSize:14.0];
        hud.bezelView.backgroundColor = [UIColor colorWithHex:0x333333];
        [hud showAnimated:YES];
    });

    
}

+ (void)hideSimpleHudWithView:(UIView *)view {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:view animated:NO];
    });
}


@end
