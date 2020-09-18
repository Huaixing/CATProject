//
//  CATTabBarController.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/1.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATTabBarController.h"

#import "CATNavigationController.h"

#import "CATHomeViewController.h"
#import "CATProfileViewController.h"

@interface CATTabBarController ()
/**overlay*/
@property (nonatomic, strong) UIView *overlayView;
@end

@implementation CATTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化，并添加子控制器
    [self addChildViewControllers];
    
//    _overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    _overlayView.backgroundColor = [UIColor blackColor];
//    _overlayView.alpha = 0.6;
//    [self.view addSubview:_overlayView];
}


#pragma mark - Private
- (void)addChildViewControllers {
    // home
    CATHomeViewController *home = [[CATHomeViewController alloc] init];
    CATNavigationController *homeNavi = [self subControllerWithRootController:home title:NSLocalizedString(@"ipets_tab_bar_home", nil) imageName:@"cat_tab_bar_profile_unselected_icon" selectedImageName:@"cat_tab_bar_profile_selected_icon"];
    // profile
    CATProfileViewController *profile = [[CATProfileViewController alloc] init];
    CATNavigationController *profileNavi = [self subControllerWithRootController:profile title:NSLocalizedString(@"ipets_tab_bar_profile", nil) imageName:@"cat_tab_bar_profile_unselected_icon" selectedImageName:@"cat_tab_bar_profile_selected_icon"];
    
    self.viewControllers = @[homeNavi, profileNavi];
}

- (CATNavigationController *)subControllerWithRootController:(CATBaseViewController *)controller title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    CATNavigationController *naviController = [[CATNavigationController alloc] initWithRootViewController:controller];
    controller.titleString = title;
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.title = title;
    return naviController;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
