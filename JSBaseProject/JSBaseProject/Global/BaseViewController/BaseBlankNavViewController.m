//
//  BaseBlankNavViewController.m
//  AnpaiPrecision
//
//  Created by Anpai on 2019/6/17.
//  Copyright © 2019 AnPai. All rights reserved.
//

#import "BaseBlankNavViewController.h"

@interface BaseBlankNavViewController () <UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation BaseBlankNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationBarTheme];
    
    // 记录系统手势代理
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated] ;
//    NSLog(@"aaaaaaa");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//   NSLog(@"qqqqqqqq") ;
    //修改为原先的红色样式
    UINavigationBar *appearance = [UINavigationBar appearance];
    NSDictionary *purchaseTextAttribute  = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor colorWithHex:FirstTextColor], [UIFont systemFontOfSize:16.0f],nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName, NSFontAttributeName, nil]];
    [appearance setTitleTextAttributes:purchaseTextAttribute];
    [appearance setBackgroundImage:[UIImage imageNamed:@"cusNavBg"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //设置UIBarButtonItem的tintColor
    appearance.tintColor = [UIColor whiteColor];
    
}

#pragma mark - UINavigationControllerDelegate
// 当控制器显示完毕的时候调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.interactivePopGestureRecognizer.enabled = YES;
    // 解决某些情况下push时的假死bug，防止把根控制器pop掉
    if (navigationController.viewControllers.count == 1) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
    //只有一个控制器的时候禁止手势，防止卡死现象
    if (self.childViewControllers.count == 1) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}


- (void)setupNavigationBarTheme{
    //通过设置appearance对象，能够修改整个项目中所有UINavigationBar的样式
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    [appearance setShadowImage:[UIImage new]];
    
    NSDictionary *purchaseTextAttribute  = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor colorWithHex:FirstTextColor], [UIFont systemFontOfSize:18.0f],nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName, NSFontAttributeName, nil]];
    [appearance setTitleTextAttributes:purchaseTextAttribute];
    
    [appearance setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    
    //设置UIBarButtonItem的tintColor
    appearance.tintColor = [UIColor colorWithHex:FirstTextColor];
    
    //设置UINavigationBar的背景色
    [appearance setBarTintColor:[UIColor whiteColor]];
    //    当translucent = YES，controller中self.view的原点是从导航栏左上角开始计算
    //    当translucent = NO，controller中self.view的原点是从导航栏左下角开始计算
    appearance.translucent = NO;
    
}



/**
 *  设置UIBarButtomItem的主题
 */
- (void)setupBarButtonItemTheme{
    //通过设置appearance对象，能够修改整个项目所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    //设置文字的属性
    //1.设置普通状体下文字的属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //设置字体
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    
    //设置颜色为白色
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //2.设置高亮状态下文字的属性
    NSMutableDictionary *hightextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    //设置颜色为红色
    hightextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [appearance setTitleTextAttributes:hightextAttrs forState:UIControlStateHighlighted];
    
    //3.设置不可用状态下文字的属性
    NSMutableDictionary *disabletextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disabletextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disabletextAttrs forState:UIControlStateDisabled];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count >0) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_icon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackVc)];
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    //push时隐藏 tabbar
    [super pushViewController:viewController animated:animated];
    
}



- (void)goBackVc {
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
