//
//  CATDetailViewController.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/5.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATDetailViewController.h"

@interface CATDetailViewController ()

@end

@implementation CATDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.leftNaviButtonItem = [[CATNaviButtonItem alloc] initWithImageName:@"cat_navigation_bar_black_back_icon" title:@"返回"];
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
