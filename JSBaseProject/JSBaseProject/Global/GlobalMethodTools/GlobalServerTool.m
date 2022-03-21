//
//  GlobalServerTool.m
//  AnpaiPrecision
//
//  Created by AnpaiPrecision on 2018/6/9.
//  Copyright © 2018年 AnpaiPrecision. All rights reserved.
//

#import "GlobalServerTool.h"
#import "SAMKeychain.h"
#import <CommonCrypto/CommonDigest.h>

@implementation GlobalServerTool

+ (NSString *)getDeviceUUIDWithSAMKeychain {
    
    NSString *tmpStr = [SAMKeychain passwordForService:@"com.rainbow.AnpaiPrecision" account:@"uuid"];
    if (![GlobalMethodsTools Object_IsNotBlank:tmpStr]) {
        NSString *uuidStr =  [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        uuidStr = [uuidStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        uuidStr = [uuidStr lowercaseString];
        tmpStr = uuidStr;
        [SAMKeychain setPassword:uuidStr forService:@"com.rainbow.AnpaiPrecision" account:@"uuid"];
    }
    return tmpStr;
}

/**上传用户地理位置信息 */
+ (void)upLoadUserLocationInfo {
//    NSDictionary *para = @{@"longitude":@"0",@"latitude":@"0"};
//    [[Http sharedInstance] requestForUrl:[NSString stringWithFormat:@"%@user/report_info",BASEURL] withParams:para completion:^(id data, NSError *error) {
//        if ([data[@"code"] integerValue] == 1) {
//            NSLog(@"用户地理位置上报成功");
//        } else {
//
//        }
//    }];
}



/**获取服务端系统配置 */
+ (void)getServerSystemConfigure {

    [[Http sharedInstance] getForUrl:[NSString stringWithFormat:@"%@api/All/AllSquareings/GetReport",BASEURL] noSignwithParams:nil completion:^(id data, NSError *error) {
        if ([data[@"RespCode"] integerValue] == 200) {
            if ([GlobalMethodsTools Object_IsNotBlank:data[@"Data"]]) {
                NSMutableArray *tmparr = [NSMutableArray arrayWithArray:data[@"Data"]] ;
                [[NSUserDefaults standardUserDefaults] setObject:tmparr forKey:@"ReportResonsData"];                
            }
        } else {
            NSLog(@"获取投诉类型失败");
        }
    }];
    
}



/**开启网络状态监听
 */
+ (void)startManagerNetWorkStatus {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //设置监听
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"不可达的网络(未连接)");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"2G,3G,4G...的网络");
                //获取服务端数据
                [GlobalServerTool getServerSystemConfigure];

                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi的网络");
                //获取服务端数据
                [GlobalServerTool getServerSystemConfigure];

                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];

}

/**关闭网络状态监听
 */
+ (void)stopManagerNetWorkStatus {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager stopMonitoring];

}


/**
 *每次App重新启动 如果用户登录 则获取一次用户信息
 */
+ (void)getUserInfoForAppLaunch {
    
    
}

/**获取用户账号信息 */
+ (NSDictionary *)getAppUserInfo {
    
    if (USERISLOGIN) {
        User *tmpUser = [UserManager sharedInstance].user;
        NSDictionary *para = @{@"uid":@"",
                               @"username":@""};
        return para;
    } else {
        NSDictionary *para = [NSDictionary dictionary];
        return para;
    }
    
}


/**审核时提供给前端的参数 */
+ (NSMutableDictionary *)getAppReviewDic {
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    return para;
    
}

/**上传推送 registerID
 *USRERegistrationID : RegistrationID + USERID
 */
+ (void)upLoadJpushRegisterID {
    
//    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
//        if(resCode == 0){
//            NSLog(@"registrationID获取成功：%@",registrationID);
//            if (USERISLOGIN) {
//                NSDictionary *para = @{@"registrationId":registrationID} ;
//                [[Http sharedInstance] getForUrl:[NSString stringWithFormat:@"%@api/Login/RecordUserRegistrationId",BASEURL]
//                                noSignwithParams:para
//                                      completion:^(id data, NSError *error) {
//                    if ([data[@"State"] integerValue] == 1) {
//                        NSLog(@"上传用户推送ID成功");
//                    }
//                }];
//            }
//        } else {
//            NSLog(@"registrationID获取失败，code：%d",resCode);
//        }
//    }];

}



/**系统分享
 */
+ (void)GlobalShareActionWithInfo:(NSMutableArray *)shareData andSimpleVC:(UIViewController *)shareVc {
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:shareData applicationActivities:nil];
    //禁用其它平台
    if (@available(iOS 9.0, *)) {
        NSArray *excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter, UIActivityTypePostToWeibo,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];
        
        activityViewController.excludedActivityTypes = excludedActivityTypes;
    } else {
        // Fallback on earlier versions
        NSArray *excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter, UIActivityTypePostToWeibo,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop];
        activityViewController.excludedActivityTypes = excludedActivityTypes;
        
    }
    activityViewController.completionWithItemsHandler = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        NSLog(@"%@  ----   %@", activityType, returnedItems);
        if (completed) {
            //            [UITools showMessage:@"分享成功" withView:self.view];
            NSLog(@"分享成功");
            return;
            //        } else if ([GlobalMethodsTools Object_IsNotBlank:activityType]){
            //            [UITools showMessage:activityError.localizedDescription withView:self.view];
        } else {
            //            [UITools showMessage:@"取消系统分享" withView:self.view];
            NSLog(@"分享失败");
            return;
        }
        
    };
    
    [shareVc presentViewController:activityViewController animated:YES completion:nil];
    
}

+ (NSDictionary *)convertJsonStringToDic:(NSString *)jsonStr {
    NSDictionary *retDict = nil;
    if ([GlobalMethodsTools Object_IsNotBlank:jsonStr]) {
        if ([jsonStr isKindOfClass:[NSString class]]) {
            NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            retDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
            return  retDict;
        }else{
            return retDict;
        }
    } else {
        return retDict;
    }
    
}

+ (NSString *)getMd5SecurityWithDic:(NSMutableDictionary *)tmpdic {
    if (![GlobalMethodsTools Object_IsNotBlank:tmpdic]) {
        NSLog(@"加密的对象有问题");
    }
    
    //对key数组进行排序
    NSArray *dictAllKeyArr = [tmpdic allKeys];
    dictAllKeyArr =  [dictAllKeyArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    //生成用来md5加密的字符串
    NSString *finalMD5Str =@"" ;
    for (int i=0; i< dictAllKeyArr.count; i++) {
        NSString *tmpkey = dictAllKeyArr[i];
        NSString *tmpValue ;
        if ([GlobalMethodsTools Object_IsNotBlank:[tmpdic objectForKey:tmpkey]]) {
            tmpValue = [NSString stringWithFormat:@"%@",[tmpdic objectForKey:tmpkey]];
            if (i==0) {
                finalMD5Str = [finalMD5Str stringByAppendingString:[NSString stringWithFormat:@"%@=%@",tmpkey,tmpValue]];
            } else {
                finalMD5Str = [finalMD5Str stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",tmpkey,tmpValue]];
            }
        }
    }
    
//    NSString *finalStr = [finalMD5Str stringByAppendingString:[NSString stringWithFormat:@"&api-secret=%@",md5SecurityString]];
    
    NSString *finalStr = finalMD5Str ;
    const char *cStr = [finalStr UTF8String];
    
    //#ifdef DEBUG
    //    NSLog(@"%@",finalStr);
    //#endif
    //
    //    NSLog(@"utf-8%s",cStr);
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    finalStr = [NSString stringWithFormat:@"%@",[result uppercaseStringWithLocale:[NSLocale currentLocale]]];
    //    NSLog(@"after---------%@",finalStr);
    
    return finalStr;
}

+ (NSDictionary *)getCommonDicPara {
    
    //设备ID
    NSString *tmpdeviceid = [GlobalServerTool getDeviceUUIDWithSAMKeychain];
    //手机系统名称
    NSString *tmpplatcode = @"ios";
    //手机系统版本名称
    NSString *tmpplatname = [UIDevice currentDevice].systemVersion;
    //app版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *tmpappversion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //网络状态
    NSString *tmpnetstatus = [GlobalMethodsTools getUserPhoneNetWorkStatus];
    //获取时间戳
    NSString *tmptimestamp = [NSString stringWithFormat:@"%ld",(NSInteger)[[NSDate date] timeIntervalSince1970] ];
    
    NSDictionary  *para = @{@"device_id":tmpdeviceid,
                            @"platform_code":tmpplatcode,
                            @"platform_version":tmpplatname,
                            @"network":tmpnetstatus,
                            @"app_version":tmpappversion,
                            @"source_code":@"appstore",
                            @"timestamp":tmptimestamp,
                            @"version_code":VERSION_CODE,
                            @"app_name":@"mmy"};
    
    return para;
}

+ (NSDictionary *)getCommonH5DicPara {
    //设备ID
    NSString *tmpdeviceid = [GlobalServerTool getDeviceUUIDWithSAMKeychain];
    //手机系统名称
    NSString *tmpplatcode = @"ios_h5";
    //手机系统版本名称
    NSString *tmpplatname = [UIDevice currentDevice].systemVersion;
    //app版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *tmpappversion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //网络状态
    NSString *tmpnetstatus = [GlobalMethodsTools getUserPhoneNetWorkStatus];
    //获取时间戳
    NSString *tmptimestamp = [NSString stringWithFormat:@"%ld",(NSInteger)[[NSDate date] timeIntervalSince1970] ];
    
    NSString *tmpuid;
    NSString *tmputoken;
    if (USERISLOGIN) {
        tmpuid = @"";
        tmputoken = @"";
    } else {
        tmpuid = @"";
        tmputoken = @"";
    }
    
    NSDictionary  *params = @{@"uid":tmpuid,
                              @"token":tmputoken,
                              @"device_id":tmpdeviceid,
                              @"platform_code":tmpplatcode,
                              @"platform_version":tmpplatname,
                              @"network":tmpnetstatus,
                              @"app_version":tmpappversion,
                              @"source_code":@"appstore",
                              @"timestamp":tmptimestamp,
                              @"version_code":VERSION_CODE,
                              @"app_name":@"mmy"};
    
    
    
    
    /**
     *针对1.1.3 以及之后的版本 新增审核状态判断参数 ：reviewstatus
     *为 1 则正在审核 ，为 0 则是其它状态
     */
    //获取本地的配置
    NSMutableDictionary *reviewDic = [GlobalServerTool getAppReviewDic];
    NSString *localStatus = [reviewDic objectForKey:@"reviewstatus"];
    
    NSMutableDictionary *commonPara = [NSMutableDictionary dictionaryWithDictionary:params];
    [commonPara setObject:localStatus forKey:@"reviewstatus"];
    params = [NSDictionary dictionaryWithDictionary:commonPara];
    
    
    return params;
    
}


/**获取广告请求公共参数 */
+ (NSDictionary *)getAdCommonDicPara {
    
    //系统版本
    NSString *osv = [UIDevice currentDevice].systemVersion;
    
    //手机运营商
    NSString *carrierStr = @"";
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    if ([GlobalMethodsTools Object_IsNotBlank: [telephonyInfo subscriberCellularProvider]]) {
        CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
        carrierStr =[carrier carrierName];
    }
    
    if (![GlobalMethodsTools Object_IsNotBlank:carrierStr]) {
        carrierStr = @"";
    }
    
    //设备制造商
    NSString *make = @"Apple Inc";
    //设备型号
    NSString *serviceModel = [GlobalServerTool getPhoneDeviceType];
    //imei
    NSString *imei = @"";
    //idfa
    NSString *idfa =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    //anid
    NSString *anid = @"";
    //屏幕宽度
    NSString *sw = [NSString stringWithFormat:@"%ld",(NSInteger)([UIScreen mainScreen].bounds.size.width)];
    //屏幕高度
    NSString *sh = [NSString stringWithFormat:@"%ld",(NSInteger)([UIScreen mainScreen].bounds.size.height)];
    
    //devicetype
    NSString *devicetype = [GlobalServerTool checkDeviceModuleType];
    
    NSDictionary *para = @{@"osv":osv,
                           @"carrier":carrierStr,
                           @"make":make,
                           @"model":serviceModel,
                           @"imei":imei,
                           @"idfa":idfa,
                           @"anid":anid,
                           @"sw":sw,
                           @"sh":sh,
                           @"devicetype":devicetype};
    
    return para;
    
}

+ (NSString *)getPhoneDeviceType {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"国行(A1863)、日行(A1906)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"美版(Global/A1905)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"国行(A1864)、日行(A1898)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"美版(Global/A1897)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"国行(A1865)、日行(A1902)iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"美版(Global/A1901)iPhone X";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,11"])    return @"iPad 5 (WiFi)";
    if ([deviceString isEqualToString:@"iPad6,12"])    return @"iPad 5 (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,1"])     return @"iPad Pro 12.9 inch 2nd gen (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,2"])     return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,3"])     return @"iPad Pro 10.5 inch (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,4"])     return @"iPad Pro 10.5 inch (Cellular)";
    
    if ([deviceString isEqualToString:@"AppleTV2,1"])    return @"Apple TV 2";
    if ([deviceString isEqualToString:@"AppleTV3,1"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV3,2"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV5,3"])    return @"Apple TV 4";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
    
}

/**判断是手机还是平板 */
+ (NSString *)checkDeviceModuleType {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return @"1";
    } else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return  @"2";
    } else {
        return @"未知设备类型";
    }
    
}


+ (void)checkMD5{
    
    NSDictionary *para = @{@"uid":@"11009070",
                           @"platform_version":@"10.3.3",
                           @"device_id":@"05e19e41a0f94244bc4b827595f923db",
                           @"platform_code":@"ios_h5",
                           @"app_version":@"1.1.1",
                           @"source_code":@"appstore",
                           @"version_code":VERSION_CODE,
                           @"token":@"620f187ab76bf16aa54394adeae722c5",
                           @"timestamp":@"1516608194",
                           @"network":@"wifi",
                           @"app_name":@"cjtt"
                           };
    
    //    NSDictionary *para = @{@"uid":@"11009070",
    //                           @"platform_version":@"10.3.3",
    //                           @"device_id":@"05e19e41a0f94244bc4b827595f923db",
    //                           @"platform_code":@"ios_h5",
    //                           @"app_version":@"1.1.1",
    //                           @"source_code":@"appstore",
    //                           @"version_code":@"1",
    //                           @"token":@"620f187ab76bf16aa54394adeae722c5",
    //                           @"timestamp":@"1516608194",
    //                           @"network":@"wifi",
    //                           @"app_name":@"cjtt",
    //                           @"page":@"0",
    //                           @"size":@"10"
    //                           };
    
    
    NSString *finalStr =  [GlobalServerTool getMd5SecurityWithDic:(NSMutableDictionary *)para];
    NSLog(@"MD5----------->%@",finalStr);
    
}

+ (void)deliverDataToWebView:(WKWebView *)wkWebView WithCallBackName:(NSString *)name WithJsonString:(NSString *)jsonStr {
    //    NSLog(@"callMethodName :%@ jsonStr : %@",name,jsonStr);
    NSLog(@"callMethodName :%@ ",name);
    
    __weak typeof(wkWebView) weakSelf = wkWebView;
    NSString *js = [NSString stringWithFormat:@"%@.callBack('%@','%@');",JSEventHandleName,name,jsonStr];
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            NSLog(@"%@",error);
        }];
    });
}

+ (void)deliverDataToWebView:(WKWebView *)wkWebView WithCallBackName:(NSString *)name WithJsonString:(NSString *)jsonStr callback:(void(^)(void))callback{
    //    NSLog(@"callMethodName :%@ jsonStr : %@",name,jsonStr);
    NSLog(@"callMethodName :%@ ",name);
    
    __weak typeof(wkWebView) weakSelf = wkWebView;
    NSString *js = [NSString stringWithFormat:@"%@.callBack('%@','%@');",JSEventHandleName,name,jsonStr];
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            NSLog(@"%@",error);
            if (callback) {
                callback();
            }
        }];
    });
}


/**上报活动日志 */
+ (void)upLoadActivityLog:(NSDictionary *)para {
    
    
}

/**比较两个时间的差值(年月日)*/
+ (NSDateComponents *)compareDateDifferenceWithStartDate:(NSString *)startDateStr andDateFormatter:(NSDateFormatter *)dateFormatter{
    
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
        dateFormatter.dateFormat = @"yyyyMMdd" ;

    }
    
    //比较两个日期的差值
    NSDate *nowdate = [NSDate date] ;
    NSLog(@"---%@",nowdate) ;
    NSString *tmpstr = [dateFormatter stringFromDate:nowdate] ;
    NSLog(@"***%@",tmpstr) ;
    
    NSString *tmpstartdate ;
    if (!startDateStr) {
        tmpstartdate = @"20220101" ;
    }
    NSDate *startDate = [dateFormatter dateFromString:tmpstartdate] ;
    NSLog(@">>>%@",startDate) ;

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay ;
//        calendar.timeZone =  [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    NSDateComponents *component ;
    if (startDate ) {
        component  = [calendar components:calendarUnit fromDate:startDate toDate:nowdate options:0] ;
    }
    NSLog(@"%@",component) ;
    return component ;
    
//    NSDateComponents
}




@end

