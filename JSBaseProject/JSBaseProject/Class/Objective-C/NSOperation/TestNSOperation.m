//
//  TestNSOperation.m
//  JSBaseProject
//
//  Created by Mini on 2021/5/20.
//

#import "TestNSOperation.h"

@interface TestNSOperation ()

@end

@implementation TestNSOperation

/**
 1. 创建操作
 2. 创建队列
 3. 将操作添加到队列中
 在不使用 NSOperationQueue，单独使用 NSOperation 的情况下系统同步执行操作
 */

//TODO:调用子类 NSInvocationOperation
- (void)userInvocationOperation {
    
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(testInvocationOperation) object:nil] ;
    [op start] ;
    
}


- (void)testInvocationOperation {
    for (int i=0; i< 3; i++) {
        NSLog(@"invocation %d %@",i,[NSThread currentThread]) ;
    }
}

@end
