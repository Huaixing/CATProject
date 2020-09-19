//
//  CATHomeViewController.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/1.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATHomeViewController.h"
#import "CATComposeViewController.h"
#import <CATPhotoKit/CATPhotoKit.h>

#import "CATNavigationController.h"

@interface CATHomeViewController ()<CATPhotoPickerControllerDelegate>

/**imageview*/
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation CATHomeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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
    CATAlbumViewController *albumController = [[CATAlbumViewController alloc] init];
    CATPhotoPickerController *pickController = [[CATPhotoPickerController alloc] initWithRootViewController:albumController];
    pickController.picker = self;
    [self cat_presentVieController:pickController animated:YES completion:nil];
}

#pragma mark - CATPhotoPickerControllerDelegate
- (void)photoPickerController:(CATPhotoPickerController *)pickerController didFinishPickPhotos:(NSArray<CATPhoto *> *)selectedPhotos {
    [pickerController dismissViewControllerAnimated:NO completion:nil];
    if (selectedPhotos.count) {
        CATComposeViewController *composeController = [[CATComposeViewController alloc] initWithPhotos:selectedPhotos];
        [self cat_presentVieController:composeController animated:YES completion:nil];
    }
}

@end
