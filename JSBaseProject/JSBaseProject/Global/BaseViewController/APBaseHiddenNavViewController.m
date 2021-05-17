//
//  BaseHiddenNavViewController.m
//  AnpaiPrecision
//
//  Created by Anpai on 2019/12/2.
//  Copyright © 2019 AnPai. All rights reserved.
//


#import "APBaseHiddenNavViewController.h"

@interface APBaseHiddenNavViewController ()
{
    float cusTopViewOutHeight ;
}

@end

@implementation APBaseHiddenNavViewController


/**
 * willAppear 与 willDisappear 继承的子类如果不需要在这两个方法中操作事件，无需继承重写，如果需要重写，记得【super 该方法】
 * 推荐不重写，页面展示与消失如果有事件要处理，推荐放在 didAppear与didiDisappe 方法中去实现
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated] ;
    self.navigationController.navigationBarHidden = YES ;

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated] ;
    self.navigationController.navigationBarHidden = NO ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cusTopViewOutHeight = (MAINNAVHEIGHT - MAINSTATUSHEIGHT) ;
    
    self.view.backgroundColor = [UIColor colorWithHex:MainBgColor] ;
    
    // Do any additional setup after loading the view.
    self.cusNavView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MAINNAVHEIGHT)];
    self.cusNavView.layer.masksToBounds = YES ;
//    self.cusNavView.backgroundColor = [UIColor colorWithHex:NBlueColor] ;
    self.cusNavView.backgroundColor = [UIColor whiteColor] ;
    [self.view addSubview:self.cusNavView];
    
//    self.cusNavbgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,MAINNAVHEIGHT )] ;
//    self.cusNavbgImageView.contentMode = UIViewContentModeScaleAspectFill ;
//    self.cusNavbgImageView.image = [UIImage imageNamed:@"flashsale_grapbg"];
//    [self.cusNavView addSubview:self.cusNavbgImageView];

        
}


- (void)mainNavLeftButClick{
//    [self.navigationController popViewControllerAnimated:YES] ;
    NSLog(@"点击左上角操作按钮");
}

- (void)mainNavRightButClick {
    NSLog(@"点击右上角操作按钮");
}

- (void)dealloc {
    NSLog(@"销毁%@",self);
}


#pragma mark -- Lazy Load
- (UIImageView *)cusNavbgImageView {
    if (!_cusNavbgImageView) {
        _cusNavbgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,MAINNAVHEIGHT )] ;
        _cusNavbgImageView.contentMode = UIViewContentModeScaleAspectFill ;
    }
    return _cusNavbgImageView ;
}

- (UIButton *)cusNavLeftBut {
    if (!_cusNavLeftBut) {
        _cusNavLeftBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _cusNavLeftBut.frame = CGRectMake(0, MAINSTATUSHEIGHT, 44, cusTopViewOutHeight);
        [_cusNavLeftBut addTarget:self action:@selector(mainNavLeftButClick) forControlEvents:UIControlEventTouchUpInside];
        _cusNavLeftBut.backgroundColor = [UIColor clearColor] ;
        _cusNavLeftBut.adjustsImageWhenHighlighted = NO ;
        [_cusNavLeftBut setImage:[UIImage imageNamed:@"main_nav_blackback"] forState:UIControlStateNormal];
//        _cusNavLeftBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _cusNavLeftBut ;
}

- (UILabel *)cusNavTitle {
    if (!_cusNavTitle) {
        _cusNavTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, MAINSTATUSHEIGHT, SCREEN_WIDTH-120, 40)];
        _cusNavTitle.font = [UIFont boldSystemFontOfSize:18.0];
        _cusNavTitle.textColor = [UIColor colorWithHex:FirstTextColor];
        _cusNavTitle.backgroundColor = [UIColor clearColor] ;
        _cusNavTitle.textAlignment = NSTextAlignmentCenter ;

    }
    return _cusNavTitle ;
}

- (UIButton *)cusNavRightBut {
    if (!_cusNavRightBut) {
        _cusNavRightBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _cusNavRightBut.frame = CGRectMake(SCREEN_WIDTH - 44, MAINSTATUSHEIGHT, 44, cusTopViewOutHeight);
        [_cusNavRightBut addTarget:self action:@selector(mainNavRightButClick) forControlEvents:UIControlEventTouchUpInside];
        _cusNavRightBut.adjustsImageWhenHighlighted = NO ;
        _cusNavRightBut.titleLabel.font = [UIFont systemFontOfSize:14.0] ;
        [_cusNavRightBut setTitleColor:[UIColor colorWithHex:FirstTextColor] forState:UIControlStateNormal];
//        _cusNavRightBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _cusNavRightBut ;

}


- (APGlobalCommonNoDataBgView *)mainNoDataBgView {
    if (!_mainNoDataBgView) {
        _mainNoDataBgView = [[APGlobalCommonNoDataBgView alloc] init];
        _mainNoDataBgView.hidden = YES ;
        _mainNoDataBgView.frame = CGRectMake(0, 50, SCREEN_WIDTH, 300);

    }
    return _mainNoDataBgView ;

}

- (GlobalNoNetWorkTipsView *)noNetBgView {
    if (!_noNetBgView) {
        _noNetBgView = [[[NSBundle mainBundle] loadNibNamed:@"GlobalNoNetWorkTipsView" owner:self options:nil] firstObject];
        _noNetBgView.hidden = YES ;
    }
    return _noNetBgView ;
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
