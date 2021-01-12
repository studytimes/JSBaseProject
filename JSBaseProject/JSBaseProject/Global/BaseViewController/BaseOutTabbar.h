//
//  BaseOutTabbar.h
//  AnpaiPrecision
//
//  Created by Anpai on 2019/6/21.
//  Copyright © 2019 AnPai. All rights reserved.
//  自定义tabbar
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BaseOutTabbarDelegate <NSObject>

- (void)selectOutTabBut;

@end


@interface BaseOutTabbar : UITabBar

@property (nonatomic, weak) id <BaseOutTabbarDelegate> bardelegate;


@end

NS_ASSUME_NONNULL_END
