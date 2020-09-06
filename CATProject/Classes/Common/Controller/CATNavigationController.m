//
//  CATNavigationController.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/1.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATNavigationController.h"

#import "CATBaseViewController.h"

#import "CATNavigationBar.h"

#import "UIView+CATSize.h"

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
    
    self.interactivePopGestureRecognizer.delegate = self;
    
    _navigatorBar = [[CATNavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.navigationBar.height + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))];
    _navigatorBar.bottom = self.navigationBar.height;
    [self.navigationBar addSubview:_navigatorBar];
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


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  if (self.viewControllers.count <= 1 ) {
      return NO;
  }
  return YES;
}

// 允许同时响应多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:
(UIGestureRecognizer *)otherGestureRecognizer {
   return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldBeRequiredToFailByGestureRecognizer:
(UIGestureRecognizer *)otherGestureRecognizer {
return [gestureRecognizer isKindOfClass:
UIScreenEdgePanGestureRecognizer.class];
}

@end
