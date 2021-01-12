//
//  UserManager.h
//  AnpaiPrecision
//
//  Created by AnPai on 2018/10/11.
//  Copyright © 2018 AnPai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserManager : NSObject

//是否登录
@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, strong) NSString *userToken ;

@property (nonatomic, strong) User *user;

+ (instancetype)sharedInstance;

- (void)getUserBaseinfo;

@end

NS_ASSUME_NONNULL_END
