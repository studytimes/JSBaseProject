//
//  DefineMacro.h
//  BaseProject
//
//  Created by Anpai on 2017/10/15.
//

#ifndef DefineMacro_h
#define DefineMacro_h

/**登录过后保存在本地的token */
#define USERTOKEN   [NSString stringWithFormat:@"bearer %@",[UserManager sharedInstance].userToken] 
#define USERISLOGIN  ([UserManager sharedInstance].isLogin)

/* 环信API */
#define EMConfigureKey @"1144200527113395#anpaiprecision"
/**Bugly日志*/
#define BUGLY_APP_ID @"2239f17373"

///**JPush */
//#define JPUSH_DEV_APPKEY @"dc198436788f5f132a8c5f83"


#endif /* DefineMacro_h */
