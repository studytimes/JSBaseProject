//
//  main.m
//  JSBaseProject
//
//  Created by Mini on 2020/12/30.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "Person.h"


int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        
        
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
