//
//  main.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/1.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CATAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([CATAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
