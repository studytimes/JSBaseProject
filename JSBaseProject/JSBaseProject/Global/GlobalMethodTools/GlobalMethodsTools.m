//
//  GlobalMethodsTools.m
//  AnpaiPrecision
//
//  Created by AnPai on 2018/10/11.
//  Copyright © 2018 AnPai. All rights reserved.
//

#import "GlobalMethodsTools.h"

@implementation GlobalMethodsTools

/**判断一个对象是否为空 */
+(BOOL)Object_IsNotBlank:(id)obj{
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objDic=(NSDictionary *)obj;
        if ([objDic allKeys].count==0) {
            return NO;
        }
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *objArray=(NSArray *)obj;
        if (objArray.count==0) {
            return NO;
        }
    }
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *objString=(NSString *)obj;
        if (objString.length==0) {
            return NO;
        }
    }
    if ( !obj || [obj isKindOfClass:[NSNull class]] ){
        return NO;
    }
    return YES;
}

/**拨打客服电话 */
+ (void)callServicePhone {
    
    NSString *telephoneNumber=@"10086";
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",telephoneNumber];
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:str];
    if (@available(iOS 10.0, *)) {
        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"拨打成功");
            }
        }];
    } else {
        [application openURL:URL];
    }
    
    
}


/**一键加入QQ群
 *目前 头条 只有一个群
 */
+ (BOOL)joinGroup:(NSString *)groupUin key:(NSString *)key{
    NSString *urlStr = [NSString stringWithFormat:@"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&key=%@&card_type=group&source=external", @"462313024",@"d1e81e1db509c9178d2acac59e9ad683f2ee56fe47df79fce0076eeb032e2101"];
    NSURL *url = [NSURL URLWithString:urlStr];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
        return YES;
    }else {
        return NO;
    }
}

/** 通过行数, 返回更新时间 */
+ (NSString *)compareCurrentTime:(NSString *)timeStamp {
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = [timeStamp floatValue];
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    if (time < 60) {
        return @"刚刚";
    }
    //秒转分
    NSInteger minute = time/60;
    if (minute<60) {
        return [NSString stringWithFormat:@"%ld分钟前",minute];
    }
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",years];
}

+ (void)clearWKWebViewCash {
    
    if (@available(iOS 9.0, *)) { // 9.0之后才有的
        NSSet *websiteDataTypes =  [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            NSLog(@"清空wk 缓存");
        }];
        
    } else {
        // Fallback on earlier versions
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) objectAtIndex:0];
        
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSLog(@"%@", cookiesFolderPath);
        NSLog(@"清空wk 缓存");
        NSError *errors;
        
        [[NSFileManager defaultManager]removeItemAtPath:cookiesFolderPath error:&errors];
    }
    
}

/**将时间戳转换成 小时与分钟 */
+ (NSString *)getHourAndMinuteWithTime:(NSString *)time {
    
    // 时间差
    NSTimeInterval tmpTime = 612221.0;
    if (tmpTime < 60) {
        return [NSString stringWithFormat:@"%.f 秒",tmpTime];
    }
    //
    //    //秒转分
    //    NSInteger minute = tmpTime/60;
    //    if (minute < 60) {
    //        return [NSString stringWithFormat:@"%ld分钟",minute];
    //    }
    //
    //    // 秒转小时
    //    NSInteger hours = tmpTime/3600;
    //    // 求剩余分钟
    //    NSInteger minute =
    //    if (hours < 24) {
    //        return [NSString stringWithFormat:@"%ld小时 分钟",hours];
    //    }
    
    return nil;
}


/**匹配昵称是否存在的正则表达式 */
+ (BOOL)checkUserNickName:(NSString *)nickStr {
    NSString *regex = @"^用户\\d{5}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:nickStr];
    return isValid;
}


/**格式化评论时间字符串 */
+ (NSString *)formateCommentTime:(NSString *)timeStamp {
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = [timeStamp floatValue];
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    if (time < 3600) {
        return @"刚刚";
    }
    //    // 秒转小时
    //    NSInteger hours = time/3600;
    //    if (hours<24) {
    //        return [NSString stringWithFormat:@"%ld小时前",hours];
    //    }
    
    //判断是否在同一年
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitMonth;
    //获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    //获得的比较时间的年月日
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:createTime];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:detaildate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if ( nowCmps.year == selfCmps.year) {//同一年
        if ((nowCmps.day == selfCmps.day) &&(nowCmps.month == selfCmps.month)) {//同一天
            return @"1小时前";
        } else {
            //设定时间格式,这里可以设置成自己需要的格式
            [dateFormatter setDateFormat:@"MM-dd HH:mm"];
            NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
            return currentDateStr;
        }
    } else {
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yy-MM-dd"];
        NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
        return currentDateStr;
    }
    
    return @"";
}

/**计算文字宽度 */
+ (CGFloat)calcuateWordsWidth:(NSString *)words height:(CGFloat)height fontSize:(CGFloat)fontSize {
    if (height==0.0) {
        height = fontSize + 5.0 ;
    }
    /*计算宽度时要确定高度 */
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};  //指定字号
    CGRect rect = [words boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return ceilf(rect.size.width);
}

/**计算文字高度 */
+ (CGFloat)calculateWordsHeight:(NSString *)words width:(CGFloat)width fontSize:(CGFloat)fontSize {
    if (width == 0.0) {
        width = SCREEN_WIDTH ;
    }

    /*计算高度时要确定宽度*/
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};  //指定字号
    CGRect rect = [words boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return ceilf(rect.size.height);

}


/**判断手机运营商网络环境
 */
+ (NSString *)checkMobileNetStatus {
    NSArray *typeStrings2G = @[CTRadioAccessTechnologyEdge,
                               CTRadioAccessTechnologyGPRS,
                               CTRadioAccessTechnologyCDMA1x];
    
    NSArray *typeStrings3G = @[CTRadioAccessTechnologyHSDPA,
                               CTRadioAccessTechnologyWCDMA,
                               CTRadioAccessTechnologyHSUPA,
                               CTRadioAccessTechnologyCDMAEVDORev0,
                               CTRadioAccessTechnologyCDMAEVDORevA,
                               CTRadioAccessTechnologyCDMAEVDORevB,
                               CTRadioAccessTechnologyeHRPD];
    
    NSArray *typeStrings4G = @[CTRadioAccessTechnologyLTE];
    
    NSString *finalStr ;
    
    CTTelephonyNetworkInfo *teleInfo= [[CTTelephonyNetworkInfo alloc] init];
    NSString *accessString = teleInfo.currentRadioAccessTechnology;
    if ([typeStrings4G containsObject:accessString]) {
        finalStr = @"4g";
    } else if ([typeStrings3G containsObject:accessString]) {
        finalStr = @"3g";
        
    } else if ([typeStrings2G containsObject:accessString]) {
        finalStr = @"2g";
    } else {
        finalStr = @"mobile";
    }
    [[NSUserDefaults standardUserDefaults] setObject:finalStr forKey:DEVICENETWORK];
    return finalStr;
}

+ (NSString *)getUserPhoneNetWorkStatus {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:DEVICENETWORK]) {
            return [[NSUserDefaults standardUserDefaults] objectForKey:DEVICENETWORK];
        }
        return @"unknown";
 }


+ (BOOL)isAvailablePhone:(NSString *)phoneStr {
    //    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    /**
     手机号码 13[0-9],14[5|7|9],15[0-3],15[5-9],17[0|1|3|5|6|8],18[0-9]
     移动：134[0-8],13[5-9],147,15[0-2],15[7-9],178,18[2-4],18[7-8]
     联通：13[0-2],145,15[5-6],17[5-6],18[5-6]
     电信：133,1349,149,153,173,177,180,181,189
     虚拟运营商: 170[0-2]电信  170[3|5|6]移动 170[4|7|8|9],171 联通
     上网卡又称数据卡，14号段为上网卡专属号段，中国联通上网卡号段为145，中国移动上网卡号段为147，中国电信上网卡号段为149
     */
    NSString * MOBIL = @"^1(3[0-9]|4[579]|5[0-35-9]|7[01356]|8[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    if ([regextestmobile evaluateWithObject:phoneStr]) {//正则校验
        return YES;
    } else {
        return NO ;
    }
}


/**校验合法的身份证*/
+(BOOL)isAvailableIdentifierCard:(NSString *)cardStr {
    
    //长度不为18的都排除掉
    if (cardStr.length != 18) {
        return NO;
    }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:cardStr];
    
    if (!flag) {
        return flag;    //格式错误
    } else {
        //格式正确在判断是否合法
        
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for (int i = 0;i < 17;i++)  {
            NSInteger subStrIndex = [[cardStr substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            
            idCardWiSum+= subStrIndex * idCardWiIndex;
            
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [cardStr substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if (idCardMod==2) {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
                return YES;
            } else {
                return NO;
            }
        } else {
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString:[idCardYArray objectAtIndex:idCardMod]]) {
                return YES;
            }  else {
                return NO;
            }
        }
    }
    return NO ;
}

/**计算应用缓存 */
+(float)caluteApplicationCash {
    
    //获得缓存路径
    NSString*cachpath  = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return [self folderSizeAtPath:cachpath];
}


//遍历缓存目录下的文件大小(M)
+ (float)folderSizeAtPath:(NSString *)folderPath{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) {
        return 0.0;
    }else{
        
        NSEnumerator *childfile = [[manager subpathsAtPath:folderPath] objectEnumerator];
        NSString *filename;
        long long folderSize=0.0;
        
        while ((filename =[childfile nextObject]) !=nil ) {
            NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:filename];
            folderSize += [self fileSizeAtPath:fileAbsolutePath];
            
        }
        
        return folderSize/(1024.0*1024.0);
    }
    
}

//计算单个缓存文件的大小
+ (long long)fileSizeAtPath:(NSString *)filepath{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filepath]) {
        return [[manager attributesOfItemAtPath:filepath error:nil] fileSize];
    }
    return 0.0;
}

+ (void)clearApplicationCash {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //缓存路径
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        //缓存下的所有文件
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        
        for (NSString *filepath in files) {
            NSError *error;
            NSString *path = [cachPath stringByAppendingPathComponent:filepath];
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        [self performSelectorOnMainThread:@selector(clearSuccess) withObject:nil waitUntilDone:YES];
    });

}

+ (void)clearSuccess {
    [GlobalUITools showMessage:@"清除成功" withView:[UIApplication sharedApplication].keyWindow];
}

/**处理页面跳转路径 */
+ (NSMutableDictionary *)dealJumpUrlWithString:(NSString *)url {
    NSMutableDictionary *finaldic = [NSMutableDictionary dictionary];
    if ([GlobalMethodsTools Object_IsNotBlank:url]) {
        NSArray *firstarr = [url componentsSeparatedByString:@"?"];
        NSString *paramstr = @"";
        for (int i=0; i<firstarr.count; i++) {//取出参数字符串
            NSString *tmpstr = [firstarr objectAtIndex:i];
            if ([tmpstr containsString:@"type="]) {
                paramstr = [NSString stringWithFormat:@"%@",tmpstr];
                break;
            }
        }
        
        if (paramstr.length > 0) {//取出参数
            NSArray *paraarr = [paramstr componentsSeparatedByString:@"&"];
            for (int i=0 ; i<paraarr.count ; i++) {
                NSArray *tmparr = [[paraarr objectAtIndex:i] componentsSeparatedByString:@"="];
                if (tmparr.count ==2) {
                    NSString *keystr = tmparr[0];
                    NSString *valuestr = tmparr[1];
                    [finaldic setObject:valuestr forKey:keystr];
                }
            }
        }

    }
    return finaldic;
}


+(NSString *)timeStampToString:(CGFloat)timeStamp {
    
    NSString *timeString = [[NSString alloc]init];
    
    //当前时间的时间戳
    NSTimeInterval  timeNow=[[NSDate date] timeIntervalSince1970];
    
    //将传来的时间戳转为标准时间格式
    NSTimeInterval time = timeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *tempStr= [dateFormatter stringFromDate:date];
    
    timeString = [NSString stringWithFormat:@"%@年%@月%@日 %@",[tempStr substringWithRange:NSMakeRange(0,4)],[tempStr substringWithRange:NSMakeRange(5,2)],[tempStr substringWithRange:NSMakeRange(8,2)],[tempStr substringWithRange:NSMakeRange(11,8)]];
    
    //当前时间
    NSDate *nowDate = [NSDate date];
    NSString *nowDateStr= [dateFormatter stringFromDate:nowDate];
    
    //时间戳判断逻辑
    if ([[timeString substringWithRange:NSMakeRange(0, 4)] isEqualToString:[nowDateStr substringWithRange:NSMakeRange(0, 4)]]) {
        
        if ([[timeString substringWithRange:NSMakeRange(5,2)] isEqualToString:[nowDateStr substringWithRange:NSMakeRange(5,2)]]) {
            
            float daySubtract = [[nowDateStr substringWithRange:NSMakeRange(8,2)] floatValue] - [[timeString substringWithRange:NSMakeRange(8,2)] floatValue];
            
            if (daySubtract < 3) {
                
                if (daySubtract == 0) {
                    
                    NSString *string = [NSString stringWithFormat:@"今天 %@",[timeString substringWithRange:NSMakeRange(11,6)]];
                    return  string;
                    
                } else if (daySubtract == 1) {
                    
                    NSString *string = [NSString stringWithFormat:@"昨天 %@",[timeString substringWithRange:NSMakeRange(11,6)]];
                    return  string;
                }else {
                    
                    if ((timeNow - time) > 3600*24*2) {
                        
                        return timeString;
                    }else {
                        
                        NSString *string = [NSString stringWithFormat:@"前天 %@",[timeString substringWithRange:NSMakeRange(11,6)]];
                        return  string;
                    }
                    
                }
                
            }else{
                
                return timeString;
            }
            
        }else {
            return timeString;
            
        }
        
    }else {
        
        return timeString;
    }
    
}

/**拨打电话 */
+ (void)callUserPhoneWithPhoneNumber:(NSString *)phone {
    
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",phone];
//    CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue]; 
    /// 大于等于10.0系统使用此openURL方法
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:nil completionHandler:nil];
    } else {
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        
    }

    
}


+ (NSData *)compressPicWithimage:(UIImage *)image {
    NSData *data=UIImageJPEGRepresentation(image, 1.0);
    if (data.length> 2048 *1024) {
        if (data.length > 10240*1024) {//100M以上
            data = UIImageJPEGRepresentation(image, 0.01);//压缩之后1M~
        } else if (data.length> 10240*2*1024) {//20M以上
            data = UIImageJPEGRepresentation(image, 0.1);//压缩之后1M~
        } else if (data.length> 10240*1024) {//10M～20M以及以上
            data = UIImageJPEGRepresentation(image, 0.1);//压缩之后1M~
        } else if (data.length> 5120*1024){//5M~10M
            data = UIImageJPEGRepresentation(image, 0.2);//压缩之后1M~2M
        } else if (data.length> 2048*1024){//2M~5M
            data = UIImageJPEGRepresentation(image, 0.4);//压缩之后0.8M~2M
        }
    }//1M~2M不压缩

    return data;

}

+(NSString *)getNowTimeTimestamp{

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //----------格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"yyyyMMddHHmmss"]; //yyyyMMddHHmmss  yyyymmddhhmmss
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSDate *formatterDate = [formatter dateFromString:currentTimeString] ;
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[formatterDate timeIntervalSince1970]];

    return timeSp;

}


///** 对字典(Key-Value)排序
// @param dict 要排序的字典
// */
//- (NSString *)sortedDictionary:(NSMutableDictionary *)dict {
//    
//    NSDictionary *para = @{@"appid":@"wx587f28fea434246e",
//                           @"mch_id":@"1483018862",
//                           @"nonce_str":@"5K8264ILTKCH16CQ2502SI8ZNMTM67VS",
//                           @"body":@"会员充值",
//                           @"out_trade_no":@"2015080612534",
//                           @"spbill_create_ip":@"192.168.10.119",
//                           @"notify_url":@"http://www.weixin.qq.com/wxpay/pay.php",
//                           @"trade_type":@"APP",
//                           @"total_fee":@"1"
//    } ;
//    
//    NSArray *keys = [para allKeys];
//    //排序
//    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        return [obj1 compare:obj2 options:NSNumericSearch];
//    }];
//    //拼接 把排序后的字典拼接成string
//    NSString *tempStr = @"";
//    //通过排列的key值获取value
//    NSMutableArray *valueArray = [NSMutableArray array];
//
//    for (NSString *categoryId in sortedArray) {
//        //格式化一下 防止有些value不是string
//        NSString *valueString = [NSString stringWithFormat:@"%@",[para objectForKey:categoryId]];
//        if(valueString.length>0){
//            [valueArray addObject:valueString];
//            
//            tempStr=[NSString stringWithFormat:@"%@%@=%@&",tempStr,categoryId,valueString];
//        }
//        
//    }
//    
//    //去除最后一个&符号
//    if(tempStr.length>0){
//        tempStr=[tempStr substringToIndex:([tempStr length]-1)];
//    }
//    
//    NSLog(@"排序好的数值:%@",tempStr) ;
//    //拼接商户密钥Key
//    NSString *stringSignTemp = [NSString stringWithFormat:@"%@&key=%@",tempStr,@"eZqrghGtuTk4axAnoNefErshiHuvUl5b"];
//    NSLog(@"拼接好的数值:%@",stringSignTemp) ;
//    
//    NSString *md5Upperstr = [self md5HashToUpper32Bit:stringSignTemp] ;
//    NSLog(@"md5加密的数值:%@",md5Upperstr) ;
//
//    
//    NSDictionary *finaldic = @{@"appid":@"wx587f28fea434246e",
//                           @"mch_id":@"1483018862",
//                           @"nonce_str":@"5K8264ILTKCH16CQ2502SI8ZNMTM67VS",
//                           @"body":@"会员充值",
//                           @"out_trade_no":@"2015080612534",
//                           @"spbill_create_ip":@"192.168.10.119",
//                           @"notify_url":@"http://www.weixin.qq.com/wxpay/pay.php",
//                           @"trade_type":@"APP",
//                           @"total_fee":@"1",
//                           @"sign":md5Upperstr
//    } ;
//NSLog(@"post数值:%@",[finaldic mj_JSONString]) ;
//
//    return md5Upperstr;
//
//}
//
//
//- (NSString *)md5HashToUpper32Bit:(NSString *)str {
//    const char *input = [str UTF8String];
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(input, (CC_LONG)strlen(input), result);
//
//    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
//        [digest appendFormat:@"%02X", result[i]];
//    }
//
//    return digest;
//}
//
//
//- (void)testWeChatPay {
//    
////    [self finalSign] ;
////    return ;
//    
//    PayReq *requset = [[PayReq alloc] init];
//    requset.partnerId = @"1483018862" ;
//    requset.prepayId= @"wx13112001926458e052c535851363424100"  ;
//    requset.package = @"Sign=WXPay";
//    requset.nonceStr=  @"kMZuHQIMKHrSLYiF" ;
//    NSString *timeStampStr=@"1584069601";
//    int timesta=[timeStampStr intValue];
//    requset.timeStamp = (UInt32)timesta;
//    requset.sign=  @"53A21D544961F6A37FC5090F52A8FEDF" ;
//    [WXApi sendReq:requset completion:^(BOOL success) {
//
//    }] ;
//
//}
//
//- (void)finalSign {
//    
//    NSDictionary *para = @{@"appid":@"wx587f28fea434246e",
//                           @"partnerid":@"1483018862",
//                           @"prepayid":@"wx131101335861795aeb2a3faf1315372400",
//                           @"package":@"Sign=WXPay",
//                           @"noncestr":@"5K8264ILTKCH16CQ2502SI8ZNMTM67VS",
//                           @"timestamp":@"1584066379"
//    } ;
//    
//    NSArray *keys = [para allKeys];
//    //排序
//    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        return [obj1 compare:obj2 options:NSNumericSearch];
//    }];
//    //拼接 把排序后的字典拼接成string
//    NSString *tempStr = @"";
//    //通过排列的key值获取value
//    NSMutableArray *valueArray = [NSMutableArray array];
//
//    for (NSString *categoryId in sortedArray) {
//        //格式化一下 防止有些value不是string
//        NSString *valueString = [NSString stringWithFormat:@"%@",[para objectForKey:categoryId]];
//        if(valueString.length>0){
//            [valueArray addObject:valueString];
//            
//            tempStr=[NSString stringWithFormat:@"%@%@=%@&",tempStr,categoryId,valueString];
//        }
//        
//    }
//    
//    //去除最后一个&符号
//    if(tempStr.length>0){
//        tempStr=[tempStr substringToIndex:([tempStr length]-1)];
//    }
//    
//    NSLog(@"排序好的数值:%@",tempStr) ;
//    //拼接商户密钥Key
//    NSString *stringSignTemp = [NSString stringWithFormat:@"%@&key=%@",tempStr,@"eZqrghGtuTk4axAnoNefErshiHuvUl5b"];
//    NSLog(@"拼接好的数值:%@",stringSignTemp) ;
//    
//    NSString *md5Upperstr = [self md5HashToUpper32Bit:stringSignTemp] ;
//    NSLog(@"md5加密的数值:%@",md5Upperstr) ;
//
//}



@end
