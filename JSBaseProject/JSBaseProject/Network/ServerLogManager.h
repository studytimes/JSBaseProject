//
//  ServerLogManager.h
//  AnpaiPrecision
//
//  Created by AnpaiPrecision on 2018/3/3.
//  Copyright © 2018年 AnpaiPrecision. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerLogManager : NSObject

+ (instancetype)ShareManager;

/**是否开始日志监控 */
@property (nonatomic, assign) BOOL isLogOn;
/**日志保存时间 */
@property (nonatomic, strong) NSString *logTime;
/**校验日志时间
 *判断日志是否需要清空
 */
+ (void)checkLogTime;

@end
