//
//  CATComposeViewController.h
//  CATProject
//
//  Created by Shihuaixing on 2020/9/15.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATBaseViewController.h"
#import <CATPhotoKit/CATPhotoKit.h>

@interface CATComposeViewController : CATBaseViewController

- (instancetype)initWithPhotos:(NSArray<CATPhoto *> *)photos;
/// 选择照片最大数量, default 9
@property (nonatomic, assign) NSUInteger photoViewMaxCount;
/// 照片布局列数，default 3
@property (nonatomic, assign) NSUInteger photoViewColumn;
/// 照片部分距离左右边距，default 24
@property (nonatomic, assign) NSUInteger photoModuleInset;
/// 照片之间间距（上下，左右），default 8
@property (nonatomic, assign) NSUInteger photoViewMargin;

@end

