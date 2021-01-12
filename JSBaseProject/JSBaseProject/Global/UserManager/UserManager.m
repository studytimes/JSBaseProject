//
//  UserManager.m
//  AnpaiPrecision
//
//  Created by AnPai on 2018/10/11.
//  Copyright © 2018 AnPai. All rights reserved.
//

#import "UserManager.h"

static NSString *const LoginStatus = @"ManagerLogin";

static NSString *const LoginToken = @"ManagerToken";

@implementation UserManager

+ (instancetype)sharedInstance {
    static UserManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserManager alloc] init];
    });
    
    return manager;
}

-(void)setUser:(User *)user{
    [NSKeyedArchiver archiveRootObject:user toFile:[self userInfoModelPath]];
}

-(User *)user{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:[self userInfoModelPath]];
    if (result) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:[self userInfoModelPath]];
    } else {
        return nil;
    }
}

-(void)setIsLogin:(BOOL)isLogin{
    //重置当前用户的登录状态
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:LoginStatus];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (isLogin) {
        //获取用户信息
        [self getUserBaseinfo];

    }
    
}

-(BOOL)isLogin{
    return [[NSUserDefaults standardUserDefaults] boolForKey:LoginStatus];
}

//保存用户token
- (void)setUserToken:(NSString *)userToken {
    [[NSUserDefaults standardUserDefaults] setObject:userToken forKey:LoginToken];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (NSString *)userToken {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:LoginToken]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:LoginToken];
    } else {
        return @""; 
    }

}


/**用户信息Model对象存储路径 */
- (NSString *)userInfoModelPath {
    //保存model的文件夹路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"userInfoModelPath.plist"]];
    return filePath;
    
}


- (void)getUserBaseinfo {

    [[Http sharedInstance] getForUrl:[NSString stringWithFormat:@"%@api/Login/GetUserInfo",BASEURL] noSignwithParams:nil completion:^(id data, NSError *error) {
        if ([data[@"State"] integerValue] == 1) {
            if ([GlobalMethodsTools Object_IsNotBlank:data[@"Data"]]) {
                User *tmpuser = [User mj_objectWithKeyValues:data[@"Data"]];
                [UserManager sharedInstance].user = tmpuser ;
                
                if ([tmpuser.isEasemobAccount isEqualToString:@"1"]) {//有环信账号则登录
                    if ([GlobalMethodsTools Object_IsNotBlank:data[@"Data"][@"easemobAccount"]]
                        && [GlobalMethodsTools Object_IsNotBlank:data[@"Data"][@"easemobPassword"]]) {
                        NSString *hxaccount = [NSString stringWithFormat:@"%@",data[@"Data"][@"easemobAccount"]];
                        NSString *hxpwd = [NSString stringWithFormat:@"%@",data[@"Data"][@"easemobPassword"]];
                        //登录环信账号
                        [self loginOrRegisterEChatAccount:hxaccount Password:hxpwd];
                    }
                }
                
                //上传推送token
                [GlobalServerTool upLoadJpushRegisterID] ;

            }
        } else {
            NSLog(@"获取用户个人信息失败");
        }
    }];

}

//注册或者登录环信
- (void)loginOrRegisterEChatAccount:(NSString *)account Password:(NSString *)password{
    NSLog(@"环信账号：%@环信密码：%@",account,password);
    NSString *tmpaccount = [NSString stringWithString:account];
    NSString *tmppassword = [NSString stringWithString:password];
//        NSString *tmpaccount = @"888888";
//        NSString *tmppassword = @"888888";
//    NSString *tmpaccount = @"666666";
//    NSString *tmppassword = @"666666";
    
//    [[EMClient sharedClient] loginWithUsername:tmpaccount password:tmppassword completion:^(NSString *aUsername, EMError *aError) {
//        if (!aError) {
//            NSLog(@"环信登录成功");
//            [[EMClient sharedClient].options setIsAutoLogin:YES];
//            if ([[NSUserDefaults standardUserDefaults] objectForKey:PhoneDeviceToken]) {
//                NSData *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:PhoneDeviceToken];
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    EMError *error =  [[EMClient sharedClient] bindDeviceToken:deviceToken];
//                    if (!error) {
//                        NSLog(@"绑定环信推送deviceToken成功");
//                    } else {
//                        NSLog(@"绑定环信推送deviceToken出错：%@",error.errorDescription);
//                    }
//                });
//            }
//
//        } else {
//            NSLog(@"环信登录出错:%d : %@",aError.code,aError.description);
//        }
//    }];
//    
}


@end
