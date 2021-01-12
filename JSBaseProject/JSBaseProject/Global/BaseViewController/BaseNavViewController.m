//
//  BaseNavViewController.m
//  BaseProject
//
//  Created by Anpai on 2017/10/15.
//

#import "BaseNavViewController.h"


@interface BaseNavViewController () <UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationBarTheme];
    
    // 记录系统手势代理
    __weak typeof(self) weakSelf = self ;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        
        self.delegate = weakSelf;
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated] ;
//    NSLog(@"redaaaaaaa");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    NSLog(@"redbbbbbb") ;
}


#pragma mark - UINavigationControllerDelegate
// 当控制器显示完毕的时候调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 解决某些情况下push时的假死bug，防止把根控制器pop掉
//    if ([viewController isKindOfClass:[GlobalUnableSlideViewController class]]) {//招聘页面单独处理
//        self.interactivePopGestureRecognizer.enabled = NO;
//    } else {
//        self.interactivePopGestureRecognizer.enabled = YES;
//    }
//    if (navigationController.viewControllers.count == 1) {
//        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//            self.interactivePopGestureRecognizer.enabled = NO;
//        }
//    }


}


- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
//    //只有一个控制器的时候禁止侧滑手势，防止卡死现象
//    if (self.childViewControllers.count == 1) {
//        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//            self.interactivePopGestureRecognizer.enabled = NO;
//        }
//    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ( gestureRecognizer == self.interactivePopGestureRecognizer ) {
        if ( self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0] ) {
            return NO;
        }
    }
    
    return YES;

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



///**
// *  设置UIBarButtomItem的主题
// */
//- (void)setupBarButtonItemTheme{
//    //通过设置appearance对象，能够修改整个项目所有UIBarButtonItem的样式
//    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
//    
//    //设置文字的属性
//    //1.设置普通状体下文字的属性
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    //设置字体
//    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
//    
//    //设置颜色为白色
//    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    
//    //2.设置高亮状态下文字的属性
//    NSMutableDictionary *hightextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
//    
//    hightextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    [appearance setTitleTextAttributes:hightextAttrs forState:UIControlStateHighlighted];
//    
//    //3.设置不可用状态下文字的属性
//    NSMutableDictionary *disabletextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
//    disabletextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    [appearance setTitleTextAttributes:disabletextAttrs forState:UIControlStateDisabled];
//}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0 ) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"main_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackVc)];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //push时隐藏 tabbar
    [super pushViewController:viewController animated:animated];

}


- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    [super setViewControllers:viewControllers animated:YES];

    if (viewControllers.count > 1 ) {
        self.tabBarController.tabBar.hidden = YES ;
    } else {
        self.tabBarController.tabBar.hidden = NO ;
    }

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
