//
//  ServerFileManager.h
//  AnpaiPrecision
//
//  Created by AnpaiPrecision on 2018/3/3.
//  Copyright © 2018年 AnpaiPrecision. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerFileManager : NSObject

+ (instancetype)ShareInstance;

+ (NSString *)serverLogFilePath;

//写文件
- (BOOL)writeFileWithData:(NSData *)data;

- (void)writeFileAsyncWithData:(NSData *)data complete:(void (^)(BOOL result))complete;

//读文件
- (NSData *)readFile;

- (void)readFileAsyncComplete:(void (^)(NSData *data))complete;

@end
