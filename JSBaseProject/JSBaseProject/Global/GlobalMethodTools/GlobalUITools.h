//
//  GlobalUITools.h
//  AnpaiPrecision
//
//  Created by AnPai on 2018/10/11.
//  Copyright © 2018 AnPai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalUITools : NSObject

//获取当前控制器
+ (UIViewController *)getCurrentVC;
/**获取当前导航栏控制器 */
+ (UINavigationController *)getCurrentNav;

/**封装MBPHUD mode = MBProgressHUDModeText（居中展示）*/
/**纯文本的提示 */
+ (void)showMessage:(NSString *)string withView:(UIView *)view;
/**整个window显示带有信息的菊花 */
+ (void)showAnimationMessage:(NSString *)string;
/**整个window显示信息 */
+ (void)showGlobalWindowMessage:(NSString *)string;
/**根据时间 展示在整个window显示信息 */
+ (void)showGlobalWindowMessage:(NSString *)string afterDelay:(NSTimeInterval)delay;
/**隐藏菊花 */
+ (void)hideAnimationMessage;
/**针对单个view的菊花 */
+ (void)showSimpleHudMessage:(NSString *)message WithView:(UIView *)view;
/**隐藏单个view菊花的样式 */
+ (void)hideSimpleHudWithView:(UIView *)view ;


@end

NS_ASSUME_NONNULL_END
