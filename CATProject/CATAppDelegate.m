//
//  CATAppDelegate.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/1.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATAppDelegate.h"

#import "CATHomeViewController.h"

@interface CATAppDelegate ()

@end

@implementation CATAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    CATHomeViewController *home = [[CATHomeViewController alloc] init];
    self.window.rootViewController = home;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
