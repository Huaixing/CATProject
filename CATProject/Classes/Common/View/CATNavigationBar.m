//
//  CATNavigationBar.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/3.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATNavigationBar.h"
#import "CATCommonMacro.h"
#import "CATNaviButtonItem.h"
#import "UIView+CATSize.h"
#import "NSString+CAT.h"

 /// 导航栏按钮距离左右按钮间距
#define CAT_NAVI_BUTTON_ITEM_MARGIN        (16)

@interface CATNavigationBar ()

/// status bar
@property (nonatomic, strong) UIView *statusBar;

/// navi bar
@property (nonatomic, strong) UIView *naviBar;

/// title on navibar
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CATNavigationBar

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        self.title = title;
        [self setupSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.statusBar.frame = CGRectMake(0, 0, self.width, CGRectGetHeight([UIApplication sharedApplication].statusBarFrame));
    
    self.naviBar.frame = CGRectMake(0, self.statusBar.bottom, self.width, self.height - self.statusBar.height);
    
    [self layoutButtonItems];
    
    [self layoutTitleView];
}

#pragma mark  Private
- (void)setupSubViews {
    
    self.backgroundColor = [UIColor whiteColor];
    // 状态栏、导航栏
    [self addSubview:self.statusBar];
    [self addSubview:self.naviBar];
    
    // 导航栏上的标题
    [self.naviBar addSubview:self.titleView];
    [self.titleView addSubview:self.titleLabel];
}

- (void)layoutButtonItems {
    
    if (_leftButtonItem) {
        _leftButtonItem.width = MAX(ceil(_leftButtonItem.width), self.naviBar.height);
        _leftButtonItem.height = self.naviBar.height;
        _leftButtonItem.x = CAT_NAVI_BUTTON_ITEM_MARGIN;
    }
    if (_rightButtonItem) {
        _rightButtonItem.frame = CGRectMake(0, 0, 44, self.naviBar.height);
        _rightButtonItem.right = self.naviBar.width;
    }
}

- (void)layoutTitleView {
    if (self.title.length) {
        
        CGFloat margin = 5;// margin between titleview and leftitem or rightitem
        CGFloat titleViewWidth = self.naviBar.width;
        if (_leftButtonItem) {
            titleViewWidth -= (_leftButtonItem.width + 16 + margin);
        }
        if (_rightButtonItem) {
            titleViewWidth -= ((_rightButtonItem.width + 16 + margin));
        }
        self.titleView.width = titleViewWidth;
        self.titleView.height = self.naviBar.height;
        self.titleView.centerX = self.naviBar.width / 2.0;
        self.titleView.y = 0;
        self.titleView.hidden = NO;
        
        self.titleLabel.frame = self.titleView.bounds;
        self.titleLabel.text = self.title;
    } else {
        self.titleView.hidden = YES;
    }
}

#pragma mark - Getter
- (UIView *)statusBar {
    if (!_statusBar) {
        _statusBar = [[UIView alloc] init];
        _statusBar.backgroundColor = [UIColor clearColor];
    }
    return _statusBar;
}

- (UIView *)naviBar {
    if (!_naviBar) {
        _naviBar = [[UIView alloc] init];
        _naviBar.backgroundColor = [UIColor clearColor];
    }
    return _naviBar;
}

- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
        _titleView.backgroundColor = [UIColor clearColor];
    }
    return _titleView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = COLOR_HEX(0x181818);
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark - Setter
- (void)setLeftButtonItem:(CATNaviButtonItem *)leftButtonItem {
    if (_leftButtonItem == leftButtonItem) {
        return;
    }
    if (_leftButtonItem) {
        [_leftButtonItem removeFromSuperview];
        _leftButtonItem = nil;
    }
    [self.naviBar addSubview:leftButtonItem];
    _leftButtonItem = leftButtonItem;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
