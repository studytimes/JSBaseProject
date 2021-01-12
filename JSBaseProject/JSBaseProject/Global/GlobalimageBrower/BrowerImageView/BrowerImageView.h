//
//  BrowerImageView.h
//  AnpaiPrecision
//
//  Created by Anpai on 2019/1/15.
//  Copyright © 2019 AnPai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BrowerImageView : UIView


@property (nonatomic, strong) UIImage *nativeImage ;

@property (nonatomic, strong) NSString *imageurlstr ; 

- (void)startLoadimage ;

@end

NS_ASSUME_NONNULL_END
