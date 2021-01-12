//
//  GlobalNoNetWorkTipsView.h
//  AnpaiPrecision
//
//  Created by jiangshuai on 2019/1/8.
//  Copyright © 2019 AnPai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalNoNetWorkTipsView : UIView

@property (nonatomic, copy) void (^tryAgainBlock) (void);


@property (weak, nonatomic) IBOutlet UIButton *tryAgainBut;


@end

NS_ASSUME_NONNULL_END
