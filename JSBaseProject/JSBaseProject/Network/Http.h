//
//  Created by admin on 15/5/12.
//  Copyright (c) 2015年 AnpaiPrecision All rights reserved.
//

#import "AFNetworking.h"

typedef void (^DataDownloadCompletion)(id data, NSError *error);

@interface Http : NSObject

+ (instancetype)sharedInstance;

///**基本的网络请求方式
// * 里面封装了参数md5加密逻辑
// */
//- (NSURLSessionTask *)requestForUrl:(NSString *)url withParams:(NSDictionary *)params completion:(DataDownloadCompletion)completion;

/**不需要md5加密的请求方法 */
- (NSURLSessionTask *)requestForUrl:(NSString *)url withNoSignParams:(NSDictionary *)params completion:(DataDownloadCompletion)completion;

//- (NSURLSessionTask *)uploadDataWithUrl:(NSString *)url withParams:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block completion:(DataDownloadCompletion)completion;
/**
 * 文件的下载
 */
-(NSURLSessionDownloadTask*)downloadForUrl:(NSString *)url  withParams:(NSDictionary *)params completion:(DataDownloadCompletion)completion;

/**单张图片上传
 */
- (NSURLSessionTask *)requestForUrl:(NSString *)url withParams:(NSDictionary *)params withImage:(UIImage *)image completion:(DataDownloadCompletion)completion;

/**多张图片上传
 */
- (NSURLSessionTask *)requestForUrl:(NSString *)url withParams:(NSDictionary *)params withImageArr:(NSMutableArray *)imageArr completion:(DataDownloadCompletion)completion;


///**基本的网络请求方式 GET
// * 里面封装了参数md5加密逻辑
// */
//- (NSURLSessionTask *)getForUrl:(NSString *)url withParams:(NSDictionary *)params completion:(DataDownloadCompletion)completion;

/**基本的网络请求方式 GET
 * 不含有加密逻辑
 */
- (NSURLSessionTask *)getForUrl:(NSString *)url noSignwithParams:(NSDictionary *)params completion:(DataDownloadCompletion)completion;

/**请求参数包含grantType特殊请求 */
- (NSURLSessionTask *)requestForUrl:(NSString *)url withGrantTypeParams:(NSDictionary *)params completion:(DataDownloadCompletion)completion;


- (NSURLSessionTask *)requestForUrl:(NSString *)url withCommonParams:(nullable id)parameters completion:(DataDownloadCompletion)completion ;


@end
