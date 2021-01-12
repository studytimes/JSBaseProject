//
//
//  Created by admin on 15/5/12.
//  Copyright (c) 2015年 AnpaiPrecision All rights reserved.
//

#import "Http.h"
#import "ServerFileHelper.h"
#import "AFNetworking.h"

#import "ServerLogManager.h"
#import "ServerFileManager.h"

static NSInteger const kTokenInvalid = 401;

@interface Http ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation Http


+ (instancetype)sharedInstance {
    static Http *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Http alloc] init];
    });
    
    return sharedInstance;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        
        //配置请求对象相关参数
        self.manager = [AFHTTPSessionManager manager];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.manager.requestSerializer setTimeoutInterval:20.0];
        [self.manager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"User-Agent"];

        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    }
    return self;
}

#pragma mark -- 不需要md5加密的网络请求
- (NSURLSessionTask *)requestForUrl:(NSString *)url withNoSignParams:(NSDictionary *)params completion:(DataDownloadCompletion)completion {
    if (!completion)
        return nil;
    
    //header里面放入token
    if (USERISLOGIN) {
        [self.manager.requestSerializer setValue:USERTOKEN forHTTPHeaderField:@"Authorization"];
    }

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if ([GlobalMethodsTools Object_IsNotBlank:params]) {
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [dict setObject:obj forKey:key];
        }];
    }
    //获取公共参数
    NSMutableDictionary *commonDic = [NSMutableDictionary dictionaryWithDictionary:[GlobalServerTool getCommonDicPara]];
    
//    [commonDic addEntriesFromDictionary:params];
    
    //公共的get请求参数串
    NSString *commonDicGetUrl = @"";
    NSArray *commonDicKeyArr = [commonDic allKeys];
    for (int i=0; i<commonDicKeyArr.count; i++) {
        NSString *tmpkey = commonDicKeyArr[i];
        NSString *tmpValue = commonDic[tmpkey];
        if (i==0 && (![commonDicGetUrl containsString:@"&"]) ) {
            commonDicGetUrl = [commonDicGetUrl stringByAppendingString:[NSString stringWithFormat:@"%@=%@",tmpkey,tmpValue]];
        } else {
            commonDicGetUrl = [commonDicGetUrl stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",tmpkey,tmpValue]];
        }
    }
    
    NSString *postUrlStr = [url stringByAppendingString:[NSString stringWithFormat:@"?%@",commonDicGetUrl]];
    postUrlStr = [postUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] ;
    
    NSLog(@"postURL:%@",postUrlStr) ;
    
    NSURLSessionTask *currentOperation;
    
    currentOperation = [self.manager POST:postUrlStr parameters:dict headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
#ifdef DEBUG
        NSLog(@"errorURL:%@",postUrlStr);
#endif

        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
//        NSDictionary *allHeaders = response.allHeaderFields;

        if ( statusCode == kTokenInvalid  && [UserManager sharedInstance].userToken.length>0 && [UserManager sharedInstance].isLogin) {
            NSLog(@"请求:%@ 提示登录状态失效 参数:%@",url,dict);
            //提示信息
            [[NSNotificationCenter defaultCenter] postNotificationName:UserTokeninvalid object:nil];
            [GlobalUITools showMessage:@"登录会话过期,请重新登录" withView:[UIApplication sharedApplication].keyWindow];
            return;
        }

        [self dealErrorMessage:error];
    }];
    return currentOperation;
    
}

- (NSURLSessionTask *)requestForUrl:(NSString *)url withCommonParams:(nullable id)parameters completion:(DataDownloadCompletion)completion {
    
    NSURLSessionTask *currentOperation;
    //公共的get请求参数串
    NSString *commonDicGetUrl = @"";
    
    NSString *postUrlStr = [url stringByAppendingString:[NSString stringWithFormat:@"%@",commonDicGetUrl]];
    postUrlStr = [postUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] ;
    
    NSLog(@"postURL:%@",postUrlStr) ;
    
//    [self.manager.requestSerializer setValue:@"bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IkhqbjQ4eEhzRWdTeDl6UGZ4SnlqeUEiLCJ0eXAiOiJhdCtqd3QifQ.eyJuYmYiOjE2MDkyMzAzMDYsImV4cCI6MTYwOTgzNTEwNiwiaXNzIjoiaHR0cDovL3NoZW5nZGFhcGkuMDUxMmlpcy5jb20iLCJhdWQiOiJiYXNlX2FwaSIsImNsaWVudF9pZCI6ImFwcCIsInN1YiI6ImFkbWluIiwiYXV0aF90aW1lIjoxNjA5MjMwMzA1LCJpZHAiOiJsb2NhbCIsIm5pY2tuYW1lIjoi566h55CG5ZGYIiwiZ2VuZGVyIjoibWFsZSIsInBpY3R1cmUiOiIiLCJuYW1lIjoi566h55CG5ZGYIiwicGhvbmVfbnVtYmVyIjoiIiwiZmFtaWx5X25hbWUiOiIiLCJpZCI6IjAwMDAwMDAwMDAwMDAwMDAwMDAiLCJwb2xpY2llcyI6WyLmtYvor5Vf5Yig6ZmkIiwi5rWL6K-VX-afpeivoiIsIua1i-ivlV_nvJbovpEiLCLmtYvor5Vf5paw5aKeIiwi55So5oi3X-mHjee9ruWvhueggSIsIumFjee9rl_nianmlpnphY3nva4iXSwicm9sZSI6IueuoeeQhuWRmCIsInNjb3BlIjpbIm9wZW5pZCIsInByb2ZpbGUiLCJiYXNlX2FwaSJdLCJhbXIiOlsiY2xpZW50X3NlY3JldF9iYXNpYyJdfQ.sszsrmTR_dYJc6QWxCAclICDd41vwCrMxNN462Sv_HJ3s-CSTCo1_Wd2f6YJpLtPcJ1-BM5yOP3OaHlSY1McNsB50FbX_KRCU_tftjAd5N1Daz6GRd1qz9d9sy7u0sYlQrRJn2ljgRSM_SbUqBE3X6a73g5fABg_wwKtvesgKcO-ykff8jxHds7S5BvfEXzw9c8uSw9csHedLvv-8hQcLpzbdhj3zviBWX-L7gN0lJ1crSsBQxoSO6LxuD9BpGjRTGQuxB7uEDQAmv1lkpV4HohJN53Oh3memBciOtteewTwgdFYKJVqjlpPAU2wwcAPSWrKmB8o1tObQb9s8shBTQ" forHTTPHeaderField:@"Authorization"];


    currentOperation = [self.manager POST:postUrlStr parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
#ifdef DEBUG
        NSLog(@"errorURL:%@",postUrlStr);
#endif

        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
//        NSDictionary *allHeaders = response.allHeaderFields;

        if ( statusCode == kTokenInvalid  && [UserManager sharedInstance].userToken.length>0 && [UserManager sharedInstance].isLogin) {
            NSLog(@"请求:%@ 提示登录状态失效 参数:%@",url,parameters);
            //提示信息
            [[NSNotificationCenter defaultCenter] postNotificationName:UserTokeninvalid object:nil];
            [GlobalUITools showMessage:@"登录会话过期,请重新登录" withView:[UIApplication sharedApplication].keyWindow];
            return;
        }

        [self dealErrorMessage:error];
    }];
    return currentOperation;

    
}

/**不含加密逻辑的get 请求 */
- (NSURLSessionTask *)getForUrl:(NSString *)url noSignwithParams:(NSDictionary *)params completion:(DataDownloadCompletion)completion {
    
    if (!completion)
        return nil;
    
    //header里面放入token
    if (USERISLOGIN) {
        [self.manager.requestSerializer setValue:USERTOKEN forHTTPHeaderField:@"Authorization"];
    }

//    CLLocation *tmpuserLocation = [MapKitManager shareInstance].userLocation ;
//    NSString *tmpLongitude = @"" ;
//    NSString *tmpLatitude = @"" ;
//    if (tmpuserLocation) {
//        tmpLongitude = [NSString stringWithFormat:@"%f",tmpuserLocation.coordinate.longitude] ;
//        tmpLatitude = [NSString stringWithFormat:@"%f",tmpuserLocation.coordinate.latitude] ;
//    }
//    [self.manager.requestSerializer setValue:tmpLongitude forHTTPHeaderField:@"Longitude"];
//    [self.manager.requestSerializer setValue:tmpLatitude forHTTPHeaderField:@"Latitude"];

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if ([GlobalMethodsTools Object_IsNotBlank:params]) {
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [dict setObject:obj forKey:key];
        }];
    }
    
//    NSMutableDictionary *commonDic = [NSMutableDictionary dictionaryWithDictionary:[GlobalServerTool getCommonDicPara]];
//
//    //将公共参数与请求参数拼成一个字典
//    [dict addEntriesFromDictionary:commonDic];

    //公共的get请求参数串
    NSString *commonDicGetUrl = @"";
    NSArray *commonDicKeyArr = [dict allKeys];
    for (int i=0; i<commonDicKeyArr.count; i++) {
        NSString *tmpkey = commonDicKeyArr[i];
        NSString *tmpValue = dict[tmpkey];
        if (i==0 && (![commonDicGetUrl containsString:@"&"])) {
            commonDicGetUrl = [commonDicGetUrl stringByAppendingString:[NSString stringWithFormat:@"%@=%@",tmpkey,tmpValue]];
        } else {
            commonDicGetUrl = [commonDicGetUrl stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",tmpkey,tmpValue]];
        }
    }
    NSString *getUrlStr = url ;
    if (commonDicGetUrl.length > 0) {
        getUrlStr  = [getUrlStr stringByAppendingString:[NSString stringWithFormat:@"?%@",commonDicGetUrl]];
    }
    
    //处理中文字符串
    getUrlStr = [getUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];


//#ifdef DEBUG
//    NSLog(@"%@",getUrlStr);
//#endif
    
    NSURLSessionTask *currentOperation;
    currentOperation = [self.manager GET:getUrlStr parameters:dict headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
#ifdef DEBUG
        NSLog(@"errorURL:%@",getUrlStr);
#endif
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
//        NSDictionary *allHeaders = response.allHeaderFields;

        if ( statusCode == kTokenInvalid  && [UserManager sharedInstance].userToken.length>0 && [UserManager sharedInstance].isLogin) {
            NSLog(@"请求:%@ 提示登录状态失效 参数:%@",url,dict);
            //提示信息
            [[NSNotificationCenter defaultCenter] postNotificationName:UserTokeninvalid object:nil];
            [GlobalUITools showMessage:@"登录会话过期,请重新登录" withView:[UIApplication sharedApplication].keyWindow];
            return;
        }

        [self dealErrorMessage:error];
    }];

    return currentOperation;

}


/**请求参数包含grantType特殊请求 */
- (NSURLSessionTask *)requestForUrl:(NSString *)url withGrantTypeParams:(NSDictionary *)params completion:(DataDownloadCompletion)completion {
        
    
    AFHTTPSessionManager *tmpmanager = [AFHTTPSessionManager manager];
    tmpmanager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [tmpmanager.requestSerializer setTimeoutInterval:20.0];
    [tmpmanager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"User-Agent"];
    
//    CLLocation *tmpuserLocation = [MapKitManager shareInstance].userLocation ;
//    NSString *tmpLongitude = @"" ;
//    NSString *tmpLatitude = @"" ;
//    if (tmpuserLocation) {
//        tmpLongitude = [NSString stringWithFormat:@"%f",tmpuserLocation.coordinate.longitude] ;
//        tmpLatitude = [NSString stringWithFormat:@"%f",tmpuserLocation.coordinate.latitude] ;
//    }
//    [tmpmanager.requestSerializer setValue:tmpLongitude forHTTPHeaderField:@"Longitude"];
//    [tmpmanager.requestSerializer setValue:tmpLatitude forHTTPHeaderField:@"Latitude"];

    NSMutableDictionary *dict = [NSMutableDictionary dictionary] ;
    if ([GlobalMethodsTools Object_IsNotBlank:params]) {
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [dict setObject:obj forKey:key];
        }];
    }

    tmpmanager.responseSerializer = [AFJSONResponseSerializer serializer];
    tmpmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        
    [tmpmanager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionTask *currentOperation;

    currentOperation = [tmpmanager POST:url parameters:dict headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
//        NSDictionary *allHeaders = response.allHeaderFields;

        if ( statusCode == kTokenInvalid  && [UserManager sharedInstance].userToken.length>0 && [UserManager sharedInstance].isLogin) {
            NSLog(@"请求:%@ 提示登录状态失效 参数:%@",url,dict);
            //提示信息
            [[NSNotificationCenter defaultCenter] postNotificationName:UserTokeninvalid object:nil];
            [GlobalUITools showMessage:@"登录会话过期,请重新登录" withView:[UIApplication sharedApplication].keyWindow];
            return;
        }

//        [self dealErrorMessage:error];
    }];
    return currentOperation;
    
}

//
//- (NSURLSessionTask *)uploadDataWithUrl:(NSString *)url withParams:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block completion:(DataDownloadCompletion)completion {
//    if (!completion) {
//        return nil;
//    }
//
//    NSURLSessionTask *currentOperation;
//
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//
//    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        [dict setObject:obj forKey:key];
//    }];
//    currentOperation = [self.manager POST:url parameters:dict headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        if (block) {
//            block(formData);
//        };
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        completion(responseObject, nil);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        completion(nil, error);
//    }];
//    return currentOperation;
//}

-(NSURLSessionDownloadTask*)downloadForUrl:(NSString *)url
                                withParams:(NSDictionary *)params
                                completion:(DataDownloadCompletion)completion{
    if (!completion) return nil;
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *task=[self.manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadProgress---%@",downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [ServerFileHelper  sharedFileHelper ].fileNameUrlPath;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"response---%@",response);
        completion(response,nil);
    }];
    [task resume];
    return task;
}

#pragma mark -- 单张图片上传
- (NSURLSessionTask *)requestForUrl:(NSString *)url withParams:(NSDictionary *)params withImage:(UIImage *)image completion:(DataDownloadCompletion)completion {

    if (!completion)
        return nil;

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    if ([GlobalMethodsTools Object_IsNotBlank:params]) {
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [dict setObject:obj forKey:key];
        }];
    }

    //header里面放入token
    if (USERISLOGIN) {
        [self.manager.requestSerializer setValue:USERTOKEN forHTTPHeaderField:@"Authorization"];
    }

    
#ifdef DEBUG
    NSMutableString *paraStr = [NSMutableString string];
    NSArray *tmpAllkeyArrs = [dict allKeys];
    NSArray *tmpValuesArrs = [dict allValues];
    for (int i=0; i< tmpAllkeyArrs.count; i++) {
        if (i == 0) {
            [paraStr appendFormat:@"?%@=%@",tmpAllkeyArrs[i],tmpValuesArrs[i]];
        } else {
            [paraStr appendFormat:@"&%@=%@",tmpAllkeyArrs[i],tmpValuesArrs[i]];
        }
    }

    NSLog(@"%@%@",url, paraStr);
#endif

    NSURLSessionTask *currentOperation;
    
    currentOperation = [self.manager POST:url parameters:dict headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        NSDate *date = [NSDate date];
        NSDateFormatter *formormat = [[NSDateFormatter alloc]init];
        [formormat setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateString = [formormat stringFromDate:date];

        NSString *fileName = [NSString  stringWithFormat:@"%@.png",dateString];

        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        double scaleNum = (double)10 *1024 *1024/imageData.length;

        if(scaleNum < 1){
            imageData = UIImageJPEGRepresentation(image, scaleNum);
        } else{
            imageData = UIImageJPEGRepresentation(image, 0.9);
        }

        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject, nil);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
//        NSDictionary *allHeaders = response.allHeaderFields;

        if ( statusCode == kTokenInvalid  && [UserManager sharedInstance].userToken.length>0 && [UserManager sharedInstance].isLogin) {
            NSLog(@"请求:%@ 提示登录状态失效 参数:%@",url,dict);
            //提示信息
            [[NSNotificationCenter defaultCenter] postNotificationName:UserTokeninvalid object:nil];
            [GlobalUITools showMessage:@"登录会话过期,请重新登录" withView:[UIApplication sharedApplication].keyWindow];
            return;
        }

    }] ;
    
    return currentOperation;
}

/**多张图片上传
 */
- (NSURLSessionTask *)requestForUrl:(NSString *)url withParams:(NSDictionary *)params withImageArr:(NSMutableArray *)imageArr completion:(DataDownloadCompletion)completion {
        if (!completion)
            return nil;

        NSMutableDictionary *dict = [NSMutableDictionary dictionary];

        if ([GlobalMethodsTools Object_IsNotBlank:params]) {
            [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                [dict setObject:obj forKey:key];
            }];
        }

        //header里面放入token
        if (USERISLOGIN) {
            [self.manager.requestSerializer setValue:USERTOKEN forHTTPHeaderField:@"Authorization"];
        }

        
    #ifdef DEBUG
        NSMutableString *paraStr = [NSMutableString string];
        NSArray *tmpAllkeyArrs = [dict allKeys];
        NSArray *tmpValuesArrs = [dict allValues];
        for (int i=0; i< tmpAllkeyArrs.count; i++) {
            if (i == 0) {
                [paraStr appendFormat:@"?%@=%@",tmpAllkeyArrs[i],tmpValuesArrs[i]];
            } else {
                [paraStr appendFormat:@"&%@=%@",tmpAllkeyArrs[i],tmpValuesArrs[i]];
            }
        }

        NSLog(@"%@%@",url, paraStr);
    #endif
    NSURLSessionTask *currentOperation;

    currentOperation = [self.manager POST:url  parameters:dict headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        for (int i=0; i<imageArr.count; i++) {
            UIImage *tmpImage = imageArr[i];
            NSDate *date = [NSDate date];
            NSDateFormatter *formormat = [[NSDateFormatter alloc]init];
            [formormat setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formormat stringFromDate:date];

            NSString *fileName = [NSString  stringWithFormat:@"%@%d.png",dateString,i];

            NSData *imageData = UIImageJPEGRepresentation(tmpImage, 1);
            double scaleNum = (double)10 *1024 *1024/imageData.length;
            NSLog(@"%f",scaleNum);
            if(scaleNum < 1 ){
                imageData = UIImageJPEGRepresentation(tmpImage, scaleNum);
            }else{
                imageData = UIImageJPEGRepresentation(tmpImage, 0.9);
            }
            [formData  appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];

        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {

        NSLog(@"---%@",uploadProgress);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject, nil);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
//        NSDictionary *allHeaders = response.allHeaderFields;

        if ( statusCode == kTokenInvalid  && [UserManager sharedInstance].userToken.length>0 && [UserManager sharedInstance].isLogin) {
            NSLog(@"请求:%@ 提示登录状态失效 参数:%@",url,dict);
            //提示信息
            [[NSNotificationCenter defaultCenter] postNotificationName:UserTokeninvalid object:nil];
            [GlobalUITools showMessage:@"登录会话过期,请重新登录" withView:[UIApplication sharedApplication].keyWindow];
            return;
        }
    }];
    return currentOperation;

}



- (void)dealErrorMessage:(NSError *)error {
    if (error.code == -1001) {
        [GlobalUITools showGlobalWindowMessage:@"请求超时！"];
    } else if (error.code == -1005 ){
        [GlobalUITools showGlobalWindowMessage:@"网络开小差，请重试~"];
    } else if (error.code == -1009) {
        [GlobalUITools showGlobalWindowMessage:@"设备无法连接到网络"];
    } else {
#ifdef DEBUG
        [GlobalUITools showMessage:[NSString stringWithFormat:@"未知错误(%ld)",error.code] withView:[UIApplication sharedApplication].keyWindow];
#endif
    }
    
}


@end





