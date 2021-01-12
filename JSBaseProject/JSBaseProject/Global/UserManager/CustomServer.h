//
//  CustomServer.h
//  AnpaiPrecision
//
//  Created by Anpai on 2019/1/24.
//  Copyright © 2019 AnPai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomServer : NSObject

//发布人ID
@property (nonatomic, copy) NSString *ReleaseUserID;
//发布人环信账号
@property (nonatomic, copy) NSString *HXAccount;
//发布人名称
@property (nonatomic, copy) NSString *ReleaseUserName;
//发布人头像
@property (nonatomic, copy) NSString *Headimgurl;
//是否是中介
@property (nonatomic, assign) NSInteger IsAgent;
//发布人手机号码
@property (nonatomic, copy) NSString *PhoneNumber;

@end

NS_ASSUME_NONNULL_END
