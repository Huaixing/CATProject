//
//  CATComposeViewController.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/15.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATComposeViewController.h"

#import "CATComposePhotoModuleView.h"
#import <CATTextKit.h>
#import "UIView+CATSize.h"

@interface CATComposeViewController ()<CATComposePhotoModuleViewDelegate>
/// content view
@property (nonatomic, strong) UIScrollView *contentView;
/// 照片显示模块
@property (nonatomic, strong) CATComposePhotoModuleView *photoModuleView;
/// text view
@property (nonatomic, strong) CATTextView *textView;

@end

@implementation CATComposeViewController

#pragma mark - Life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.photoModuleView];
    [self.contentView addSubview:self.textView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    _photoModuleView.frame = CGRectMake(16, self.navigationBar, self.view.width, 88);
}

#pragma mark - Getter
- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _contentView.backgroundColor = [UIColor greenColor];
    }
    return _contentView;
}

- (CATComposePhotoModuleView *)photoModuleView {
    if (!_photoModuleView) {
        _photoModuleView = [[CATComposePhotoModuleView alloc] initWithDelegate:self];
        _photoModuleView.backgroundColor = [UIColor redColor];
    }
    return _photoModuleView;
}

- (CATTextView *)textView {
    if (!_textView) {
        _textView = [[CATTextView alloc] init];
        _photoModuleView.backgroundColor = [UIColor blueColor];
    }
    return _textView;
}


@end
