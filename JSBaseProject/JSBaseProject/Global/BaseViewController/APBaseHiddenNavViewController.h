//
//  APBaseHiddenNavViewController.h
//  AnpaiPrecision
//
//  Created by Anpai on 2019/12/2.
//  Copyright © 2019 AnPai. All rights reserved.
//

//  自定义导航栏控制器
//  子类ViewController 继承改类，可每个控制自定义导航栏颜色、返回按钮、
//  视图通用的控件可作为属性申明在 .h文件中


#import <UIKit/UIKit.h>
#import "GlobalNoNetWorkTipsView.h"
#import "APGlobalCommonNoDataBgView.h"



NS_ASSUME_NONNULL_BEGIN

@interface APBaseHiddenNavViewController : UIViewController

/**自定义导航*/
@property (nonatomic, strong) UIView *cusNavView ;
/**自定义导航栏背景图片*/
@property (nonatomic, strong) UIImageView *cusNavbgImageView;
/**自定义导航栏背景视图*/
//@property (nonatomic, strong) UIView *cusTitleBgView;
/**自定义导航栏标题*/
@property (nonatomic, strong) UILabel *cusNavTitle;
/**自定义返回*/
@property (nonatomic, strong) UIButton *cusNavLeftBut ;
/**自定义右侧*/
@property (nonatomic, strong) UIButton *cusNavRightBut ;
/**没有网络状态的背景 */
@property (nonatomic, strong) GlobalNoNetWorkTipsView *noNetBgView;
/**没有数据的提示*/
@property (nonatomic, strong) APGlobalCommonNoDataBgView *mainNoDataBgView ;


- (void)mainNavLeftButClick ;

- (void)mainNavRightButClick ;

@end

NS_ASSUME_NONNULL_END
