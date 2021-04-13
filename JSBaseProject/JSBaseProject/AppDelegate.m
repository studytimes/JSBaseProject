//
//  AppDelegate.m
//  JSBaseProject
//
//  Created by Mini on 2020/12/30.
//

#import "AppDelegate.h"

#import "BaseFunctionViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor  = [UIColor whiteColor];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO ;
    [IQKeyboardManager sharedManager].enable = NO ;
    [IQKeyboardManager sharedManager].previousNextDisplayMode = IQPreviousNextDisplayModeAlwaysHide ;

    BaseFunctionViewController *funvc = [[BaseFunctionViewController alloc] init];
    BaseNavViewController *rootnavvc = [[BaseNavViewController alloc] initWithRootViewController:funvc];
    
    self.window.rootViewController = rootnavvc ;
    [self.window makeKeyAndVisible] ;
    
    return YES;
}



@end
