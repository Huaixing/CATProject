//
//  CATAppDelegate.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/1.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATAppDelegate.h"

#import "CATTabBarController.h"

@interface CATAppDelegate ()

@end

@implementation CATAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    CATTabBarController *tabBar = [[CATTabBarController alloc] init];
    self.window.rootViewController = tabBar;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
