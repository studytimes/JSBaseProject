//
//  GlobalServerTool.h
//  AnpaiPrecision
//
//  Created by AnpaiPrecision on 2018/6/9.
//  Copyright © 2018年 AnpaiPrecision. All rights reserved.
//  与服务端接口 以及与 h5页面有逻辑交互的公共方法类
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "sys/utsname.h"
#import <AdSupport/AdSupport.h>


@interface GlobalServerTool : NSObject

/**获取设备的唯一标志
 *用UUID 外加 SAMKeychain的方式来保存
 */
+ (NSString *)getDeviceUUIDWithSAMKeychain;

/**上传用户地理位置信息 */
+ (void)upLoadUserLocationInfo;


/**获取服务端系统配置 */
+ (void)getServerSystemConfigure;

/**开启网络状态监听
 */
+ (void)startManagerNetWorkStatus;

/**关闭网络状态监听
 */
+ (void)stopManagerNetWorkStatus;


/**
 *每次App重新启动 如果用户登录 则获取一次用户信息
 */
+ (void)getUserInfoForAppLaunch;

/**获取用户账号信息 */
+ (NSDictionary *)getAppUserInfo;

/**审核时提供给前端的参数 */
+ (NSMutableDictionary *)getAppReviewDic;

/**上传JPush registerID */
+ (void)upLoadJpushRegisterID;

/**全局的系统分享调用方法
 */
+ (void)GlobalShareActionWithInfo:(NSMutableArray *)shareData andSimpleVC:(UIViewController *)shareVc;

/**把字符串序列化成字典对象 */
+ (NSDictionary *)convertJsonStringToDic:(NSString *)jsonStr;

/**生成Md5加密后的字符串
 */
+ (NSString *)getMd5SecurityWithDic:(NSMutableDictionary *)tmpdic;

/**获取功能参数 */
+ (NSDictionary *)getCommonDicPara;

/**获取html5请求参数 */
+ (NSDictionary *)getCommonH5DicPara;

/**获取广告请求公共参数 */
+ (NSDictionary *)getAdCommonDicPara;

/**获取手机型号 */
+ (NSString *)getPhoneDeviceType;

/**校验内部MD5加密 */
+ (void)checkMD5;

/**上报活动日志 */
+ (void)upLoadActivityLog:(NSDictionary *)para;

/**WKWebView调用h5页面中的 js方法 */
+ (void)deliverDataToWebView:(WKWebView *)wkWebView WithCallBackName:(NSString *)name WithJsonString:(NSString *)jsonStr ;
/**WKWebView调用h5页面中的 js方法 block */
+ (void)deliverDataToWebView:(WKWebView *)wkWebView WithCallBackName:(NSString *)name WithJsonString:(NSString *)jsonStr callback:(void(^)(void))callback;


@end
