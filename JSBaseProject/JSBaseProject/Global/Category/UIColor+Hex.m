//
//  UIColor+Hex.m
//  AGG_V2
//
//  Created by admin on 15/5/12.
//  Copyright (c) 2015年 AnpaiPrecision All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue {
	return [UIColor colorWithRed:((float) ((hexValue & 0xFF0000) >> 16)) / 255.0
						   green:((float) ((hexValue & 0xFF00) >> 8)) / 255.0
							blue:((float) (hexValue & 0xFF)) / 255.0
						   alpha:alphaValue];
}

+ (UIColor *)colorWithHex:(NSInteger)hexValue {
	return [UIColor colorWithHex:hexValue alpha:1.0];
}

@end
