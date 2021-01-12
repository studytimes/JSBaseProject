//
//  CustomServerManager.h
//  AnpaiPrecision
//
//  Created by Anpai on 2019/1/24.
//  Copyright © 2019 AnPai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomServer.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomServerManager : NSObject

@property (nonatomic, strong) CustomServer *customer;

+ (instancetype)ShareInstance;

@end

NS_ASSUME_NONNULL_END
