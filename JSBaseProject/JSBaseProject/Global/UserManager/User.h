//
//  User.h
//  AnpaiPrecision
//
//  Created by AnPai on 2018/10/11.
//  Copyright © 2018 AnPai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject


@property (nonatomic, copy) NSString *uID;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *userCode;

@property (nonatomic, copy) NSString *phone;
/**是否是领导*/
@property (nonatomic, copy) NSString *isLeader;
/**是否能够创建群聊*/
@property (nonatomic, copy) NSString *isGroupChat;

@property (nonatomic, copy) NSString *userHeardImg;
/**环信账号*/
@property (nonatomic, copy) NSString *easemobAccount;
/**环信密码*/
@property (nonatomic, copy) NSString *easemobPassword;

/**部门ID*/
@property (nonatomic, copy) NSString *departmentId;
/**部门*/
@property (nonatomic, copy) NSString *departmentName;
/**是生产或质检人员*/
@property (nonatomic, copy) NSString *productionOrQuality;
/**是否分配了环信账号*/
@property (nonatomic, copy) NSString *isEasemobAccount;
/**是否需要代理负责人*/
@property (nonatomic, copy) NSString *isNeedAgent;


@end

NS_ASSUME_NONNULL_END
