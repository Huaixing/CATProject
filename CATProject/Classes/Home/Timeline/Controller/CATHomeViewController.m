//
//  CATHomeViewController.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/1.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATHomeViewController.h"
#import "CATComposeViewController.h"
#import "CATDetailViewController.h"
#import <CATPhotoKit/CATPhotoKit.h>

#import "CATNavigationController.h"

#import "CATHomeMomentCell.h"
#import "CATHomeMomentLayout.h"

@interface CATHomeViewController ()<CATPhotoPickerControllerDelegate>
/// tableview
@property (nonatomic, strong) UITableView *tableView;
/// moment layout list
@property (nonatomic, strong) NSMutableArray<CATHomeMomentLayout *> *momentLayouts;
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
    
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Private
- (NSMutableArray<CATHomeMomentLayout *> *)momentLayouts {
    if (!_momentLayouts) {
        _momentLayouts = [[NSMutableArray alloc] init];
    }
    return _momentLayouts;
}

#pragma mark - Action
- (void)leftNaviButtonItemDidClick:(CATNaviButtonItem *)sender {
    CATAlbumViewController *albumController = [[CATAlbumViewController alloc] init];
    CATPhotoPickerController *pickController = [[CATPhotoPickerController alloc] initWithRootViewController:albumController];
    pickController.picker = self;
    [self cat_presentVieController:pickController animated:YES completion:nil];
//    CATDetailViewController *detail = [[CATDetailViewController alloc] init];
//    [self cat_pushVieController:detail animated:YES];
}

#pragma mark - CATPhotoPickerControllerDelegate
- (void)photoPickerController:(CATPhotoPickerController *)pickerController didFinishPickPhotos:(NSArray<CATPhoto *> *)selectedPhotos {
    [pickerController dismissViewControllerAnimated:NO completion:nil];
    if (selectedPhotos.count) {
        CATComposeViewController *composeController = [[CATComposeViewController alloc] initWithPhotos:selectedPhotos];
        [self cat_presentVieController:composeController animated:YES completion:nil];
    }
}


#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _tableView;
}
@end
