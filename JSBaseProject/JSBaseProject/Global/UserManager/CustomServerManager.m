//
//  CustomServerManager.m
//  AnpaiPrecision
//
//  Created by Anpai on 2019/1/24.
//  Copyright © 2019 AnPai. All rights reserved.
//

#import "CustomServerManager.h"

@implementation CustomServerManager


+ (instancetype)ShareInstance {
    static CustomServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CustomServerManager alloc] init];
    });
    
    return manager;

}


- (void)setCustomer:(CustomServer *)customer {
    
    [NSKeyedArchiver archiveRootObject:customer toFile:[self customerInfoModelPath]];

}


- (CustomServer *)customer {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:[self customerInfoModelPath]];
    if (result) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:[self customerInfoModelPath]];
    } else {
        return nil;
    }

}


/**客服信息Model对象存储路径 */
- (NSString *)customerInfoModelPath {
    
    //保存model的文件夹路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"customerInfoModelPath.plist"]];
    return filePath;
    
}



@end
