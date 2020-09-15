//
//  CATBaseViewController.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/1.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATBaseViewController.h"
#import "CATNavigationController.h"
#import "CATNavigationBar.h"

@interface CATBaseViewController ()

@end

@implementation CATBaseViewController

#pragma mark - Life
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.leftNaviButtonItem = [[CATNaviButtonItem alloc] initWithImageName:@"cat_navigation_bar_black_back_icon" title:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_CONTROLLER_BACKGROUND;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置导航栏内容
    [self setupNavigationBarContent];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - Private

/// 设置导航栏内容
- (void)setupNavigationBarContent {
    // 设置title
    [self setupNavigationBarTitle];
    // 设置左右按钮
    [self setupNavigationBarButton];
}

/// 设置title
- (void)setupNavigationBarTitle {
    self.navigationBar.title = self.titleString;
}

/// 设置导航栏左右按钮
- (void)setupNavigationBarButton {
    
    if (_leftNaviButtonItem) {
        self.navigationBar.leftButtonItem = _leftNaviButtonItem;
    }
    if (_rightNaviButtonItem) {
        self.navigationBar.rightButtonItem = _rightNaviButtonItem;
    }
    
}

#pragma mark - Public

- (CATNavigationBar *)navigationBar {
    if (self.navigationController) {
        BOOL iscatNaviClass = [self.navigationController isKindOfClass:[CATNavigationController class]];
        if (iscatNaviClass) {
            CATNavigationController *catNaviController = (CATNavigationController *)self.navigationController;
            return catNaviController.navigatorBar;
        }
    }
    return nil;
}

- (void)setTitleString:(NSString *)titleString {
    if ([_titleString isEqualToString:titleString]) {
        return;
    }
    _titleString = [titleString copy];
    self.navigationBar.title = self.titleString;
}

- (void)setLeftNaviButtonItem:(CATNaviButtonItem *)leftNaviButtonItem {
    if (_leftNaviButtonItem == leftNaviButtonItem) {
        return;
    }
    _leftNaviButtonItem = leftNaviButtonItem;
    [_leftNaviButtonItem addTarget:self action:@selector(leftNaviButtonItemDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupNavigationBarContent];
}

- (void)cat_pushVieController:(CATBaseViewController *)controller animated:(BOOL)animated {
    [self.navigationController pushViewController:controller animated:animated];
}

#pragma mark - Action
- (void)leftNaviButtonItemDidClick:(CATNaviButtonItem *)sender {
    
}
@end
