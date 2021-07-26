//
//  DefineTheme.h
//  BaseProject
//
//  Created by Anpai on 2017/10/15.
//

#ifndef DefineTheme_h
#define DefineTheme_h

/**常用的距离 */
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
/**刘海屏幕的适配 */
#define hasLiuHaiScreen ({ \
    BOOL IsLiuHaiScreen = NO; \
    if (@available(iOS 11.0, *)) { \
        if (@available(iOS 12.0, *) && [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {\
        IsLiuHaiScreen = YES; \
        } \
        UIEdgeInsets safeAreaInsets = [UIApplication sharedApplication].windows[0].safeAreaInsets;\
        IsLiuHaiScreen =  (safeAreaInsets.top >0) || (safeAreaInsets.bottom >0 ) || (safeAreaInsets.left >0) || (safeAreaInsets.right >0 ); \
    }\
    IsLiuHaiScreen ;\
})

#define MAINSTATUSHEIGHT ((hasLiuHaiScreen)? 44.0 : 20.0)

#define MAINNAVHEIGHT ((hasLiuHaiScreen) ? 88.0 : 64.0)
#define MAINTABHEIGHT ((hasLiuHaiScreen) ? 83.0 : 49.0)

#define ADJUSTOPHEIGHT ((hasLiuHaiScreen) ? 44.0 : 0.0)
#define ADJUSBOTHEIGHT ((hasLiuHaiScreen) ? 34.0 : 0.0)

/**有导航栏二级子页面高度 */
#define GLOBALSUBHEIGHT (SCREEN_HEIGHT-MAINNAVHEIGHT-ADJUSBOTHEIGHT)

/**新的导航栏文字颜色 */
#define MainNavTextColor 0x000000
/**文字三级色彩 */
#define FirstTextColor 0x333333
#define SecondTextColor 0x666666
#define ThirdTextColor 0x999999
/**分割线颜色 */
#define SeparatorColor 0xE9E9E9
/**统一的背景色 */
#define MainBgColor 0xF6F6F6

/**定义根据屏幕比例调整控件大小、字体大小的宏方法 */
#define  CONVERT_SCALE(a) ((int)(a*([UIScreen mainScreen].bounds.size.width/375.0)))


#endif /* DefineTheme_h */
