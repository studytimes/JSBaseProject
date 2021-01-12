//
//  ServerFileManager.m
//  AnpaiPrecision
//
//  Created by AnpaiPrecision on 2018/3/3.
//  Copyright © 2018年 AnpaiPrecision. All rights reserved.
//

#import "ServerFileManager.h"

static char* const queueName = "servreLogManagerQueue";

@interface ServerFileManager () {
    //读写队列
    dispatch_queue_t readWriteQueue;
}

@property (nonatomic, strong) NSString *filePath;

@end

@implementation ServerFileManager

+ (instancetype)ShareInstance {
    static ServerFileManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerFileManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        readWriteQueue = dispatch_queue_create(queueName, DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (NSData *)readFile
{
    __block NSData *data;
    dispatch_sync(readWriteQueue, ^{
        if([[NSFileManager defaultManager] fileExistsAtPath:self.filePath]){
            data = [[NSFileManager defaultManager] contentsAtPath:self.filePath];
        }
    });
    return data;
}

- (void)readFileAsyncComplete:(void (^)(NSData *data))complete
{
    dispatch_async(readWriteQueue, ^{
        NSData *data = nil;
        if([[NSFileManager defaultManager] fileExistsAtPath:self.filePath]){
            data = [[NSFileManager defaultManager] contentsAtPath:self.filePath];
        }
        
        if (complete) {
            complete(data);
        }
    });
}

- (BOOL)writeFileWithData:(NSData *)data
{
    __block BOOL result = NO;
    dispatch_barrier_sync(readWriteQueue, ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if(![fileManager fileExistsAtPath:self.filePath]){
            result = [[NSFileManager defaultManager] createFileAtPath:self.filePath contents:nil attributes:nil];
        }
        
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:self.filePath];
        [fileHandle seekToEndOfFile];  //将节点跳到文件的末尾
        [fileHandle writeData:data];
        [fileHandle closeFile];
        NSLog(@"写文件：");
    });
    return result;
}

- (void)writeFileAsyncWithData:(NSData *)data complete:(void (^)(BOOL result))complete
{
    __block BOOL result = NO;
    dispatch_barrier_async(readWriteQueue, ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if(![fileManager fileExistsAtPath:self.filePath]){
            result = [[NSFileManager defaultManager] createFileAtPath:self.filePath contents:nil attributes:nil];
        }
        
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:self.filePath];
        [fileHandle seekToEndOfFile];  //将节点跳到文件的末尾
        [fileHandle writeData:data];
        [fileHandle closeFile];
        if (complete) {
            complete(result);
        }
    });
}


-(NSString *)filePath {
    if (!_filePath) {
        _filePath = [ServerFileManager serverLogFilePath];
    }
    return _filePath;
}

+ (NSString *)serverLogFilePath {
    //保存model的文件夹路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"serverLogFilePath.txt"]];
    return filePath;
    
}


@end
