//
//  GlobalBrowserImageListVC.h
//  AnpaiPrecision
//
//  Created by Anpai on 2019/1/14.
//  Copyright © 2019 AnPai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalBrowserImageListVC : UIViewController

/**本地图片 */
@property (nonatomic, strong) NSMutableArray *nativeImageGroupArr;
/**网络资源图片 */
@property (nonatomic, strong) NSMutableArray *imageUrlGroupArr;

@property (nonatomic, assign) NSInteger startTag ;

@property (nonatomic, strong) UIButton *saveBut ;

@end

NS_ASSUME_NONNULL_END
