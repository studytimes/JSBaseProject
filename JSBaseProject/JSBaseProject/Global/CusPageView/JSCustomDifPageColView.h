//
//  JSCustomDifPageColView.h
//  IntelligentCoffee
//
//  Created by Mini on 2021/6/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSCustomDifPageColView : UIView


/**普通大小*/
@property (nonatomic, assign)  CGSize normalDotSize ;
/**当前大小*/
@property (nonatomic, assign)  CGSize currentDotSize ;
/**当前颜色*/
@property (nonatomic)  UIColor *currentDotColor ;
/**普通颜色*/
@property (nonatomic)  UIColor *normalDotColor ;
/**当前图片*/
@property (nonatomic,strong)  UIImage *currentDotImage ;
/**普通图片*/
@property (nonatomic,strong)  UIImage *normalDotImage ;

@property (nonatomic, assign) NSInteger totalPage ;

@property (nonatomic, assign) NSInteger currentPage ;
/**圆点之间的间距*/
@property (nonatomic, assign) float innerSpace ;

@end

NS_ASSUME_NONNULL_END
