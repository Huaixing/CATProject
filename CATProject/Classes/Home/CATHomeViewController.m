//
//  CATHomeViewController.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/1.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATHomeViewController.h"


#import "CATDetailViewController.h"

@interface CATHomeViewController ()

/**imageview*/
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation CATHomeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleString = @"首页";
        self.leftNaviButtonItem = [[CATNaviButtonItem alloc] initWithImageName:@"cat_navigation_bar_black_back_icon" title:@"返回"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 88, 100, 200)];
    [self.view addSubview:_imageView];
    
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://testlib.qbb6.com/content/1847783988641_97fa7e68935b.png"]];
    UIImage *image = [UIImage imageWithData:data];
    _imageView.image = image;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)leftNaviButtonItemDidClick:(CATNaviButtonItem *)sender {
    
    CATDetailViewController *detail = [[CATDetailViewController alloc] init];
    [self cat_pushVieController:detail animated:YES];
}

@end
