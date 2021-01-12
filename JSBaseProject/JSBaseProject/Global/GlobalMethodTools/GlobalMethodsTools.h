//
//  GlobalMethodsTools.h
//  AnpaiPrecision
//
//  Created by AnPai on 2018/10/11.
//  Copyright © 2018 AnPai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface GlobalMethodsTools : NSObject


/**判断一个对象是否为空 */
+(BOOL)Object_IsNotBlank:(id)obj;

/**拨打客服电话 */
+ (void)callServicePhone;


/**一键加入QQ群 */
+ (BOOL)joinGroup:(NSString *)groupUin key:(NSString *)key;

/**计算两个时间的时间差 */
+ (NSString *)compareCurrentTime:(NSString *)timeStamp ;

/**清空WKWebView缓存 */
+ (void)clearWKWebViewCash;

/**将时间戳转换成 小时与分钟 */
+ (NSString *)getHourAndMinuteWithTime:(NSString *)time;

///**生成唯一的字符串 */
//+ (NSString *)getUniqueString;

/**匹配昵称是否存在的正则表达式 */
+ (BOOL)checkUserNickName:(NSString *)nickStr;

/**格式化评论时间字符串 */
+ (NSString *)formateCommentTime:(NSString *)timeStamp;

/**计算文字长度 */
+ (CGFloat)calcuateWordsWidth:(NSString *)words height:(CGFloat)height fontSize:(CGFloat)fontSize ;

/**计算文字高度 */
+ (CGFloat)calculateWordsHeight:(NSString *)words width:(CGFloat)width fontSize:(CGFloat)fontSize ;

/**计算应用缓存 */
+(float)caluteApplicationCash;
/**清除应用缓存 */
+ (void)clearApplicationCash;

/**校验合法的手机号 */
+(BOOL)isAvailablePhone:(NSString *)phoneStr ;

/**校验合法的身份证*/
+(BOOL)isAvailableIdentifierCard:(NSString *)cardStr ;


/**获取设备网络状态 */
+ (NSString *)getUserPhoneNetWorkStatus;

/**判断手机运营商网络环境 */
+ (NSString *)checkMobileNetStatus;

///*转换成富文本字符串 */
//+ (NSMutableAttributedString *)changeTagString:(NSString *)str ;

+ (void)clearSuccess;

/**处理页面跳转路径 */
+ (NSMutableDictionary *)dealJumpUrlWithString:(NSString *)url ;


+(NSString *)timeStampToString:(CGFloat)timeStamp ;

/**拨打电话 */
+ (void)callUserPhoneWithPhoneNumber:(NSString *)phone;

/**压缩图片 */
+ (NSData *)compressPicWithimage:(UIImage *)image;


/**获取北京东八区时间戳*/
+(NSString *)getNowTimeTimestamp ;


@end

NS_ASSUME_NONNULL_END
