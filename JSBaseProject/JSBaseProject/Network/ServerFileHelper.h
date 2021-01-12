//
//  Created by AnpaiPrecision on 2018/3/1.
//  Copyright © 2018年 AnpaiPrecision. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerFileHelper : NSObject
@property (nonatomic,strong)NSURL *fileNameUrlPath;
/**
 *  单例模式
 */
+ (instancetype) sharedFileHelper;
@end
