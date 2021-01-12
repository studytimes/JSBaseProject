//
//  BaseMoreRecognizeScrollerView.m
//  AnpaiPrecision
//
//  Created by jiangshuai on 2019/11/15.
//  Copyright © 2019 AnPai. All rights reserved.
//

#import "APBaseMoreRecognizeScrollerView.h"

@implementation APBaseMoreRecognizeScrollerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



#pragma mark --  UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES ;
}

@end
