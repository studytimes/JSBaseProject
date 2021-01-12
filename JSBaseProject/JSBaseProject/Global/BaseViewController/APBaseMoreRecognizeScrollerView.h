//
//  APBaseMoreRecognizeScrollerView.h
//  AnpaiPrecision
//
//  Created by jiangshuai on 2019/11/15.
//  Copyright © 2019 AnPai. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *支持内嵌scrollerview，同时响应滑动手势事件
 */

NS_ASSUME_NONNULL_BEGIN

@interface APBaseMoreRecognizeScrollerView : UIScrollView <UIGestureRecognizerDelegate>

@end

NS_ASSUME_NONNULL_END
