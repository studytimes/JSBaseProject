//
//  ServerLogManager.m
//  AnpaiPrecision
//
//  Created by AnpaiPrecision on 2018/3/3.
//  Copyright © 2018年 AnpaiPrecision. All rights reserved.
//

#import "ServerLogManager.h"
#import "ServerFileManager.h"

static NSString* const ServerLogSwitch = @"ServerLogSwitch";

static NSString* const LocalServerLogTime = @"LocalServerLogTime";

@interface ServerLogManager ()

/**当前系统保存的日志时间 */
@property (nonatomic, strong) NSString *localLogTime;


@end

@implementation ServerLogManager


+ (instancetype)ShareManager {
    static ServerLogManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerLogManager alloc] init];
    });
    return manager;
}

- (void)setIsLogOn:(BOOL)isLogOn {
    [[NSUserDefaults standardUserDefaults] setBool:isLogOn forKey:ServerLogSwitch];
}

- (BOOL)isLogOn {
    return [[NSUserDefaults standardUserDefaults] boolForKey:ServerLogSwitch];
}

//- (NSString *)nowLogTime {
// return [NSUserDefaults standardUserDefaults]
//}

/**检验日志时间
 *如果超出 24 小时 则清空当前日志
 */
+ (void)checkLogTime {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:LocalServerLogTime]) {
        
        NSString *localTimeval = [[NSUserDefaults standardUserDefaults] objectForKey:LocalServerLogTime];
        NSInteger timeinterval = (NSInteger)[[NSDate date] timeIntervalSince1970];
        
        if ((timeinterval - [localTimeval integerValue]) >3600*24 ) {//如果前后间隔超过24小时
            //清空本地的日志文件
            NSFileManager *tmpManager = [NSFileManager defaultManager];
            NSString *logFilePath = [ServerFileManager serverLogFilePath];
            if ([tmpManager fileExistsAtPath:logFilePath]) {
                NSError *logerror = nil;
                BOOL result = [tmpManager removeItemAtPath:logFilePath error:&logerror];
                if (result) {
                    NSLog(@"清空原先的日志文件成功");
                    //更新本地的日志时间
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",timeinterval] forKey:LocalServerLogTime];
                } else {
                    NSLog(@"清空日志文件出错:%@",[logerror localizedDescription]);
                }
            } else {
                NSLog(@"日志文件不存在") ;
            }
            
        } else {
            NSLog(@"本地日志文件暂未过期");
        }
        
    } else {//没有日志存储过

        NSLog(@"本地没有日志记录");
        NSInteger timeinterval = (NSInteger)[[NSDate date] timeIntervalSince1970];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",timeinterval] forKey:LocalServerLogTime];
        
    }
    
}

@end
