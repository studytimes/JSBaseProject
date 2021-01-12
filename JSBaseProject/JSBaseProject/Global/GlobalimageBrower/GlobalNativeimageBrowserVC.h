//
//  GlobalNativeimageBrowserVC.h
//  AnpaiPrecision
//
//  Created by Anpai on 2019/3/12.
//  Copyright © 2019 AnPai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalNativeimageBrowserVC : UIViewController

/**本地图片 */
@property (nonatomic, strong) NSMutableArray *nativeImageGroupArr;
/**网络资源图片 */
@property (nonatomic, strong) NSMutableArray *imageUrlGroupArr;

@property (nonatomic, assign) NSInteger startTag ;

@property (nonatomic, assign) BOOL isShowSaveBut;

@end

NS_ASSUME_NONNULL_END
