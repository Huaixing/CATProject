//
//  CATNavigationController.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/1.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATNavigationController.h"
#import "CATBaseViewController.h"

@interface CATNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation CATNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 去掉导航栏自带的底部黑线
    self.navigationBar.shadowImage = [[UIImage alloc] init];
    // 导航栏透明
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    // 设置右滑返回手势的代理为自身
    __weak typeof(self) weakself = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = (id)weakself;
    }
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.hidesBackButton = YES;
    }
    if ([viewController isKindOfClass:[CATBaseViewController class]]) {

    }
    self.interactivePopGestureRecognizer.enabled = NO;
    [super pushViewController:viewController animated:animated];
}


#pragma mark - UIGestureRecognizerDelegate
// 这个方法是在手势将要激活前调用：返回YES允许右滑手势的激活，返回NO不允许右滑手势的激活
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        // 屏蔽调用rootViewController的滑动返回手势，避免右滑返回手势引起死机问题
        if (self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    // 这里就是非右滑手势调用的方法啦，统一允许激活
    return YES;
}

@end
