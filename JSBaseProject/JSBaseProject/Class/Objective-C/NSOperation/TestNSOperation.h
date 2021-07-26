//
//  TestNSOperation.h
//  JSBaseProject
//
//  Created by Mini on 2021/5/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^MyName)(NSString *a,NSString *b);

@interface TestNSOperation : NSObject


@property (nonatomic, copy) MyName nameBlock;

@property (nonatomic, assign) CGSize tmpsize;


@end

NS_ASSUME_NONNULL_END
