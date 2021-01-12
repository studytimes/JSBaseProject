//
//
//  Created by AnpaiPrecision on 2018/3/1.
//  Copyright © 2018年 AnpaiPrecision. All rights reserved.
//

#import "ServerFileHelper.h"

@implementation ServerFileHelper
/**
 * 创建单例
 */
+ (instancetype)sharedFileHelper
{
    static ServerFileHelper *_helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _helper = [[ServerFileHelper alloc]init];
    });
    
    return _helper;
}
/**
 *  初始化时创建数据库
 */
- (id)init{
    self = [super init];
    if (self) {
//      [self initializeFileWithName:kJSPATCH_PATH];
    }
    return self;
}
/**
 * @brief 初始化数据操作
 */
- (void)initializeFileWithName:(NSString *) name
{
    if (!name) return ;  // 返回数据创建失败
    NSArray *URLs = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *directoryURL = [URLs firstObject];
    NSURL *baseURL = [directoryURL URLByAppendingPathComponent:name];
   
    NSString *scriptPath=[[baseURL.absoluteString componentsSeparatedByString:@"file:/"] lastObject];
    NSError *error;
    if ([[NSFileManager defaultManager]removeItemAtPath:scriptPath error:&error]==YES) {
        NSLog(@"---------------has delete fileNameUrlPath  :%@",self.fileNameUrlPath);
    }
    self.fileNameUrlPath=baseURL;
}
@end
