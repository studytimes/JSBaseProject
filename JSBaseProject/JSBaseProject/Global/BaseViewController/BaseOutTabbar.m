//
//  BaseOutTabbar.m
//  AnpaiPrecision
//
//  Created by Anpai on 2019/6/21.
//  Copyright © 2019 AnPai. All rights reserved.
//

#import "BaseOutTabbar.h"


@interface BaseOutTabbar ()

//中间发布按钮
@property (nonatomic, strong) UIButton *centerAddBut;
////顶部阴影效果
@property (nonatomic, strong) UIView *shadowView;


@end

@implementation BaseOutTabbar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)init {
    self = [super init];
    if (self) {
        //删除tabbar顶部的那根线条
        [self setBackgroundImage:[UIImage new]];
        [self setShadowImage:[UIImage new]];
        [self configCenterButViews];
        
    }
    return self;
}


- (void)configCenterButViews {
    
    //添加阴影效果
    self.shadowView.backgroundColor = [UIColor whiteColor];
    self.shadowView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
//    self.shadowView.layer.shadowColor = [UIColor colorWithHex:0x000000].CGColor;
//    self.shadowView.layer.shadowOffset = CGSizeMake(0, -3);
//    self.shadowView.layer.shadowOpacity = 0.5;
    //    self.shadowView.clipsToBounds = NO;
    self.shadowView.backgroundColor = [UIColor colorWithHex:0xF0F0F0];
    [self addSubview:self.shadowView];

    
    //添加发布按钮
    self.centerAddBut.bounds = CGRectMake(0, 0, 50, 50);
    self.centerAddBut.center = CGPointMake(SCREEN_WIDTH/2, 10 );
//    self.centerAddBut.layer.cornerRadius = 25.0;
    self.centerAddBut.clipsToBounds = YES;
    self.centerAddBut.backgroundColor = [UIColor clearColor];
    [self.centerAddBut setImage:[UIImage imageNamed:@"tab_btn_cailiao"] forState:UIControlStateNormal];
    self.centerAddBut.adjustsImageWhenHighlighted = NO;
    [self.centerAddBut addTarget:self action:@selector(centerAddButClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.centerAddBut];
    
}

- (void)layoutSubviews {
    [self bringSubviewToFront:self.shadowView];

    [self bringSubviewToFront:self.centerAddBut];

}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.hidden == NO) {
        UIView *tmpView = [super hitTest:point withEvent:event];
        if (tmpView == nil) {
            //转换坐标
            CGPoint tempPoint = [self.centerAddBut convertPoint:point fromView:self];
            //判断点击的点是否在按钮区域内
            if (CGRectContainsPoint(self.centerAddBut.bounds, tempPoint)){
                //返回按钮
                return self.centerAddBut;
            }
        }
        return tmpView;
        
    } else {
        return [super hitTest:point withEvent:event];
    }
}

- (void)centerAddButClick {
    NSLog(@"点击了发布按钮");
    if (!self.hidden) {
        if (self.bardelegate  && [self.bardelegate respondsToSelector:@selector(selectOutTabBut)]) {
            [self.bardelegate selectOutTabBut];
        }
    }
}

#pragma mark -- Lazy Load

- (UIButton *)centerAddBut {
    if (!_centerAddBut) {
        _centerAddBut = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    return _centerAddBut;
}

- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
    }
    return _shadowView ;
}

@end
