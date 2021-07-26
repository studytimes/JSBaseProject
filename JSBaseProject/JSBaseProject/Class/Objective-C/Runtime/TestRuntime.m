//
//  TestRuntime.m
//  JSBaseProject
//
//  Created by Mini on 2021/5/18.
//

#import "TestRuntime.h"
#import <objc/runtime.h>

#import "Person.h"


@implementation TestRuntime

/**
 iOS对象在运行时动态创建对象和类、实现消息传递与转发的机制
 
 */
- (void)method {
//    objc_msgSend(self, SEL) ;
//    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:@[@"1",@"2",2,5,9,3,4,1]] ;
    /**isa 指针指向这个对象对应的那个类*/
    NSLog(@"%@", [self class]);
    
    Person *p = [Person new] ;
    Class c1 = [p class] ;
    Class c2 = [Person class] ;
    
    NSLog(@"%d", c1 == c2) ;
    
    
}


@end
