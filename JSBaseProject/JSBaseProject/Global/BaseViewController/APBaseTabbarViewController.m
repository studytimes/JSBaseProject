//
//  APBaseTabbarViewController.m
//  AnpaiPrecision
//
//  Created by Anpai on 2017/10/16.
//  Copyright © 2017年 AnpaiPrecision. All rights reserved.
//

#import "APBaseTabbarViewController.h"
#import "BaseNavViewController.h"

#import "AppDelegate.h"


@interface APBaseTabbarViewController () <UITabBarControllerDelegate>

@property (nonatomic ,strong) UIView *tabShadowView ;
/**名称 */
@property (nonatomic, strong) NSArray *itemsNameArr;
/**图片 */
@property (nonatomic, strong) NSArray *itemsImageArr;

@end

@implementation APBaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //搭建底部tabbar
    [self configTabbarTheme];
    
    //定义视图控制器
    [self configTabbar];

    //添加通知监听
    [self addGlobalNotification];
    
//    //判断用户阅读政策信息弹窗
//    [self checkUserPolicy] ;
    
        
}


- (void)checkUserPolicy {
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:AgressMainPolicy]) {
//        self.policyAlterView = [[[NSBundle mainBundle] loadNibNamed:@"APGlobalPolicyAlterView" owner:self options:nil] firstObject];
//        self.policyAlterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) ;
//        self.policyAlterView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5] ;
//        MJWeakSelf
//        self.policyAlterView.seePolicyBlock = ^{
//            GlobalCommonLinkURLViewController *globalvc = [[GlobalCommonLinkURLViewController alloc] init];
//            globalvc.urlType = 0 ;
//            globalvc.isPresented = YES ;
//            globalvc.modalPresentationStyle = UIModalPresentationFullScreen ;
//            [weakSelf presentViewController:globalvc animated:YES completion:nil];
//        };
//        self.policyAlterView.seePrivateBlock = ^{
//            GlobalCommonLinkURLViewController *globalvc = [[GlobalCommonLinkURLViewController alloc] init];
//            globalvc.urlType = 1 ;
//            globalvc.isPresented = YES ;
//            globalvc.modalPresentationStyle = UIModalPresentationFullScreen ;
//            [weakSelf presentViewController:globalvc animated:YES completion:nil];
//        };
//        [self.view addSubview:self.policyAlterView];
//    }

}

- (void)addGlobalNotification {
    
    //用户token失效 重新登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoginView) name:UserTokeninvalid object:nil];

}


- (void)removeGlobalNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UserTokeninvalid object:nil];

}


- (void)configTabbar {
    

    self.tabBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -3);
    self.tabBar.layer.shadowOpacity = 0.3;
    self.tabBar.layer.shadowRadius = 3.0 ;
    self.tabBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.tabBar.bounds].CGPath ;
    
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage new]];
    self.tabBar.barStyle = UIBarStyleBlack ;

//
//    BaseNavViewController *nav1 = [[BaseNavViewController alloc]
//                                   initWithRootViewController:[APMessageMainViewController new]];
//
//    BaseNavViewController *nav2 = [[BaseNavViewController alloc] initWithRootViewController:[APWholeProduceMainViewController new]];
//
//    BaseNavViewController *nav3 =  [[BaseNavViewController alloc]
//                                    initWithRootViewController:[APWholeOfficeMainViewController new]];
//    BaseNavViewController *nav4 =  [[BaseNavViewController alloc]
//                                    initWithRootViewController:[MineMainViewControlller new]];
//
//    self.viewControllers = @[nav1,nav2,nav3,nav4];
    MJWeakSelf

    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.title = [NSString stringWithString:self.itemsNameArr[idx]];
        [obj setImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@unsel",weakSelf.itemsImageArr[idx]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [obj setSelectedImage:[[UIImage imageNamed:[weakSelf.itemsImageArr[idx] stringByAppendingString:@"seled"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        obj.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0) ;
    }];
    
//    [self.tabBar bringSubviewToFront:self.tabShadowView];
//    float singleitemWidth = floorf(SCREEN_WIDTH / self.itemsImageArr.count) ;
    
//    [self.tabBar addSubview:self.lineOneView];
//    self.lineOneView.frame = CGRectMake(singleitemWidth, 12, 0.5, 24) ;
//    [self.tabBar bringSubviewToFront:self.lineOneView];
//
//    [self.tabBar addSubview:self.lineTwoView];
//    self.lineTwoView.frame = CGRectMake(singleitemWidth * 2, 12, 0.5, 24) ;
//    [self.tabBar bringSubviewToFront:self.lineTwoView];

    //默认选中生产页面
    self.selectedIndex = 1 ;
        
}



- (void)configTabbarTheme {
    //解决iOS 12下 tabbar出现时跳动的bug
    [UITabBar appearance].translucent = NO;
    //适配iOS 13
    if (@available(iOS 13.0, *)) {//tabbar标题颜色无法修改问题
        [[UITabBar appearance] setUnselectedItemTintColor:[UIColor colorWithHex:0x999999]];
        [[UITabBar appearance] setTintColor:[UIColor blueColor]];

    }

    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];

    //通过设置appearance 对象，能够修改整个项目中所有UITabBarItem的样式
    UITabBarItem *appearance = [UITabBarItem appearance];
    
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor colorWithHex:0x999999],[UIFont systemFontOfSize:11.0f],nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName, NSFontAttributeName, nil]] forState:UIControlStateNormal];
    
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor blueColor], [UIFont systemFontOfSize:11.0f], nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName, NSFontAttributeName, nil]] forState:UIControlStateSelected];
    
    
}


#pragma mark -- UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
//    NSLog(@"%lu",(unsigned long)tabBarController.selectedIndex);
//    if (viewController == [tabBarController.viewControllers objectAtIndex:3] || [viewController isKindOfClass:[ShopCarMainViewController class]]) {//登录才能查看购物车
//        if (USERISLOGIN) {
//            return YES;
//        } else {
//            [self showLoginView] ;
//            return NO;
//        }
//    }
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.selectedViewController beginAppearanceTransition: YES animated: animated];
}

- (void) viewDidAppear:(BOOL)animated {
    
    [self.selectedViewController endAppearanceTransition];

}

- (void) viewWillDisappear:(BOOL)animated {
    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
}

- (void) viewDidDisappear:(BOOL)animated {
    [self.selectedViewController endAppearanceTransition];

}

#pragma makr -- showLoginView
- (void)showLoginView {//弹出登录页面
    //清除当前的登录状态
    [UserManager sharedInstance].isLogin = NO;

    dispatch_async(dispatch_get_main_queue(), ^{
        //获取当前的视图控制器对象
        UIViewController *currentVC = [GlobalUITools getCurrentVC] ;
        NSLog(@"%@",[currentVC class]);
        
//        //如果当前页面已经是登录页面 就不需要再次弹出登录
//        if ([currentVC isKindOfClass:[APMainLoginViewController class]] || [currentVC.presentedViewController isKindOfClass:[APMainLoginViewController class]]) {
//            NSLog(@"不再次弹窗");
//            return ;
//        } else {
//            dispatch_async(dispatch_get_main_queue(), ^{//重设置根试图控制器
//                AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate ;
//                BaseNavViewController *rootNav = [[BaseNavViewController alloc] initWithRootViewController:[APMainLoginViewController new]];
//                appDelegate.window.rootViewController = rootNav ;
//            });
//        }

    });

}

#pragma mark -- Lazy Load
- (NSArray *)itemsNameArr {
    if (!_itemsNameArr) {
        _itemsNameArr = @[@"消息",@"生产",@"办公",@"我的"] ;
    }
    return _itemsNameArr;
}

- (NSArray *)itemsImageArr {
    
    if (!_itemsImageArr) {
        _itemsImageArr = @[@"tabbar_xiaoxi_",@"tabbar_shengchan_",@"tabbar_bangong_",@"tabbar_wode_"];
    }
    return _itemsImageArr;
}

- (void)dealloc {
    //移除通知
    [self removeGlobalNotification];
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
