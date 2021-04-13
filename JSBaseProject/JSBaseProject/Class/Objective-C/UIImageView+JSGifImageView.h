//
//  UIImageView+JSGifImageView.h
//  JSBaseProject
//
//  Created by Mini on 2021/4/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Extension是Category的一个特例。类扩展与分类相比只少了分类的名称，所以称之为“匿名分类”。
 为一个类添加额外的原来没有变量，方法(必须要实现)和属性,一般的类扩展写到.m文件中 ,一般的私有属性写到.m文件中的类扩展中
 */
@interface UIImageView ()

- (void)loadGifimage ;

@end

NS_ASSUME_NONNULL_END
