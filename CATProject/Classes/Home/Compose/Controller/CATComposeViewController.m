//
//  CATComposeViewController.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/15.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATComposeViewController.h"

#import "CATComposePhotoModuleView.h"
#import <CATTextKit/CATTextKit.h>
#import <CATCommonKit/CATCommonKit.h>
#import <Masonry/Masonry.h>
#import <CATPhotoKit/CATPhotoKit.h>

@interface CATComposeViewController ()<CATComposePhotoModuleViewDelegate, CATPhotoDownLoadDelegate, CATPhotoPickerControllerDelegate>
/// scroll view
@property (nonatomic, strong) UIScrollView *scrollView;
/// content view
@property (nonatomic, strong) UIView *contentView;

/// text view
@property (nonatomic, strong) CATTextView *textView;

/// 照片显示模块
@property (nonatomic, strong) CATComposePhotoModuleView *photoModuleView;
/// image views
@property (nonatomic, strong) NSMutableArray<CATComposePhotoView *> *photoViews;
/// photos
@property (nonatomic, strong) NSArray<CATPhoto *> *photos;

/// 地理位置
@property (nonatomic, strong) UIView *locationView;
/// icon
@property (nonatomic, strong) UIImageView *locationIconView;
/// title
@property (nonatomic, strong) UILabel *locationTitleLabel;
/// content
@property (nonatomic, strong) UILabel *locationContentLabel;


@end

@implementation CATComposeViewController

#pragma mark - Life
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.photoViewMaxCount = 9;
        self.photoViewColumn = 3;
        self.photoModuleInset = 24;
        self.photoViewMargin = 8;
        
        self.titleString = NSLocalizedString(@"ipets_compose_title_string", nil);
        self.leftNaviButtonItem = [[CATNaviButtonItem alloc] initWithTitle:NSLocalizedString(@"ipets_compose_left_canel_string", nil) imageName:nil];
        self.rightNaviButtonItem = [[CATNaviButtonItem alloc] initWithTitle:NSLocalizedString(@"ipets_compose_right_save_string", nil) imageName:nil buttonType:CATButtonTypeCircleColor];
    }
    return self;
}

- (instancetype)initWithPhotos:(NSArray<CATPhoto *> *)photos {
    if (self = [super init]) {
        self.photos = photos;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    
    [self.contentView addSubview:self.textView];
    [self.contentView addSubview:self.photoModuleView];
    
    [self.contentView addSubview:self.locationView];
    [self.locationView addSubview:self.locationIconView];
    [self.locationView addSubview:self.locationTitleLabel];
    [self.locationView addSubview:self.locationContentLabel];
    
}

- (void)updateViewConstraints {
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView.mas_width);
    }];
    
    // text
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@100);
    }];
    
    // photo
    if (self.photos.count) {
        self.photoModuleView.hidden = NO;
        [self updatePhotoModuleConstraints];
    } else {
        self.photoModuleView.hidden = YES;
    }
    
    // location
    [self updateLocationConstraints];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.locationView);
    }];
    [super updateViewConstraints];
}

#pragma mark - Private

/// 初始化照片列表，如果照片数小于最大上限，则在最后加上添加按钮（哨兵photo）
/// @param photos 初始列表
- (void)setPhotos:(NSArray<CATPhoto *> *)photos {
    NSMutableArray *list = [NSMutableArray arrayWithArray:photos];
    if (list.count < self.photoViewMaxCount) {
        // 哨兵photo（添加按钮）
        CATPhoto *sentryPhoto = [[CATPhoto alloc] init];
        [list addObject:sentryPhoto];
    }
    _photos = [list copy];
}

/// 在原来的照片列表中新加入的选择的照片
/// @param photos 新选择的照片
- (void)appendPhotos:(NSArray<CATPhoto *> *)photos {
    NSMutableArray *list = [NSMutableArray arrayWithArray:self.photos];
    // 先删除哨兵photo（添加按钮）
    [list removeLastObject];
    // 在添加新加入的照片
    [list addObjectsFromArray:photos];
    self.photos = list;
}

- (void)updatePhotoModuleConstraints {
    
    // 显示照片的真正部分宽度
    CGFloat photoContentWidth = (CGRectGetWidth([UIScreen mainScreen].bounds) - 2 * self.photoModuleInset);
    CGFloat imageWH = (photoContentWidth - (self.photoViewColumn - 1) * self.photoViewMargin) / self.photoViewColumn;
    
    CATComposePhotoView *layoutedView = nil;
    for (NSInteger index = 0; index < self.photoViews.count; index ++) {
        CATComposePhotoView *imageView = [self.photoViews objectAtIndex:index];
        
        NSInteger colIndex = index % self.photoViewColumn;
        if (index < self.photos.count) {
            
            CATPhoto *photo = [self.photos objectAtIndex:index];
            imageView.photo = photo;
            // 设置图片
            if (photo.asset == nil) {
                imageView.image = [UIImage imageNamed:@"cat_compose_add_photo_icon"];
                imageView.contentMode = UIViewContentModeCenter;
                imageView.backgroundColor = [UIColor colorWithHexString:@"0xF7F7FB"];
            } else {
                imageView.backgroundColor = [UIColor clearColor];
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                [[CATPhotoManager shareManager] requestAssetImageWithPhoto:photo targetSize:CGSizeMake(imageWH, imageWH) delegate:self];
            }
            
            imageView.hidden = NO;
            [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(imageWH);
                make.width.mas_equalTo(imageWH);
                
                if (layoutedView == nil) {
                    // 第一个image vie
                    make.top.equalTo(self.photoModuleView);
                    make.left.equalTo(self.photoModuleView).offset(self.photoModuleInset);
                } else {
                    if (colIndex == 0) {
                        // 左起第一个image view
                        make.top.equalTo(layoutedView.mas_bottom).offset(self.photoViewMargin);
                        make.left.equalTo(self.photoModuleView).offset(self.photoModuleInset);
                    } else {
                        make.top.equalTo(layoutedView);
                        make.left.equalTo(layoutedView.mas_right).offset(self.photoViewMargin);
                    }
                }
            }];
            layoutedView = imageView;
        } else {
            imageView.hidden = YES;
        }
    }
    [self.photoModuleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(layoutedView);
    }];
}

- (void)updateLocationConstraints {
    
    CGFloat inset = self.photoModuleInset;
    [self.locationIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.photoModuleInset);
        make.top.equalTo(self.locationView).offset(12);
        make.size.mas_equalTo(self.locationIconView.image.size);
    }];
    
    [self.locationTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.locationView);
        make.centerY.equalTo(self.locationIconView);
        make.left.equalTo(self.locationIconView.mas_right).offset(12);
        make.right.equalTo(self.locationView).offset(-inset);
    }];
    [self.locationContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.locationTitleLabel.mas_bottom).offset(12);
        make.left.equalTo(self.locationIconView.mas_right).offset(12);
        make.right.equalTo(self.locationView).offset(-inset);
        make.bottom.equalTo(self.locationView);
    }];
    [self.locationView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.photoModuleView.isHidden) {
            make.top.equalTo(self.textView.mas_bottom).offset(40);
        } else {
            make.top.equalTo(self.photoModuleView.mas_bottom).offset(40);
        }
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.locationContentLabel);
    }];
    
}

- (BOOL)hasContent {
    if (self.textView.text.length) {
        return YES;
    }
    if (self.photos.count) {
        return YES;
    }
    return NO;
}

#pragma mark - CATPhotoDownLoadDelegate
- (void)photoManagerDownLoadSuccess:(CATPhotoManager *)manager result:(UIImage *)result identifier:(NSString *)identifier {
    for (CATComposePhotoView *imageView in self.photoViews) {
        if ([imageView.photo.localIdentifier isEqualToString:identifier]) {
            imageView.image = result;
        }
    }
}

#pragma mark - CATPhotoPickerControllerDelegate
- (void)photoPickerController:(CATPhotoPickerController *)pickerController didFinishPickPhotos:(NSArray<CATPhoto *> *)selectedPhotos {
    [pickerController dismissViewControllerAnimated:YES completion:nil];
    // 新添加的照片
    [self appendPhotos:selectedPhotos];
    [self updateViewConstraints];
}

#pragma mark - Action
- (void)imageViewHandleGesture:(UITapGestureRecognizer *)gesture {
    CATComposePhotoView *imageView = (CATComposePhotoView *)gesture.view;
    if (imageView.photo.asset == nil) {
        // 添加照片
        CATAlbumViewController *albumController = [[CATAlbumViewController alloc] init];
        CATPhotoPickerController *pickController = [[CATPhotoPickerController alloc] initWithRootViewController:albumController];
        pickController.picker = self;
        [self cat_presentVieController:pickController animated:YES completion:nil];
    }
}

- (void)leftNaviButtonItemDidClick:(CATNaviButtonItem *)sender {
    
    if ([self hasContent]) {
        // 还有内容，点击取消发表
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.alwaysBounceVertical = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (CATComposePhotoModuleView *)photoModuleView {
    if (!_photoModuleView) {
        _photoModuleView = [[CATComposePhotoModuleView alloc] initWithDelegate:self];
        _photoModuleView.backgroundColor = [UIColor clearColor];
        _photoModuleView.hidden = YES;
        
        for (NSInteger index = 0; index < self.photoViewMaxCount; index ++) {
            CATComposePhotoView *imageView = [[CATComposePhotoView alloc] init];
            imageView.backgroundColor = [UIColor clearColor];
            imageView.clipsToBounds = YES;
            [_photoModuleView addSubview:imageView];
            [self.photoViews addObject:imageView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewHandleGesture:)];
            [imageView addGestureRecognizer:tap];
        }
        
    }
    return _photoModuleView;
}

- (CATTextView *)textView {
    if (!_textView) {
        _textView = [[CATTextView alloc] init];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.textContainerInset = UIEdgeInsetsMake(24, 24, 0, 24);
        _textView.contentInset = UIEdgeInsetsMake(0, 0, 24, 0);
        _textView.placeHolder = NSLocalizedString(@"ipets_compose_text_placeholder_string", nil);
        _textView.placeHolderFont = [UIFont systemFontOfSize:16];
        _textView.placeHolderColor = [UIColor colorWithHexString:@"0x69707F"];
    }
    return _textView;
}

- (UIView *)locationView {
    if (!_locationView) {
        _locationView = [[UIView alloc] init];
        _locationView.backgroundColor = [UIColor greenColor];
    }
    return _locationView;
}

- (UIImageView *)locationIconView {
    if (!_locationIconView) {
        _locationIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cat_compose_location_icon"]];
        _locationIconView.backgroundColor = [UIColor clearColor];
    }
    return _locationIconView;
}

- (UILabel *)locationTitleLabel {
    if (!_locationTitleLabel) {
        _locationTitleLabel = [[UILabel alloc] init];
        _locationTitleLabel.backgroundColor = [UIColor redColor];
        _locationTitleLabel.text = @"LocationLocationLocationLocationLocationLocationLocationLocationLocationLocationLocationLocationLocationLocation";
        _locationTitleLabel.textColor = [UIColor blackColor];
//        [_locationTitleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _locationTitleLabel;
}

- (UILabel *)locationContentLabel {
    if (!_locationContentLabel) {
        _locationContentLabel = [[UILabel alloc] init];
        _locationContentLabel.backgroundColor = [UIColor blueColor];
        _locationContentLabel.text = @"starbucks";
        _locationContentLabel.textColor = [UIColor blackColor];
//        [_locationContentLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _locationContentLabel;
}

- (NSMutableArray<CATComposePhotoView *> *)photoViews {
    if (!_photoViews) {
        _photoViews = [[NSMutableArray alloc] initWithCapacity:self.photoViewMaxCount];
    }
    return _photoViews;
}

@end
