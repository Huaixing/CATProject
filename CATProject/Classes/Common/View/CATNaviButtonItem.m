//
//  CATNaviButtonItem.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/4.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATNaviButtonItem.h"
#import "NSString+CATSize.h"
#import <CATCommonKit/CATCommonKit.h>
#import "CATCommonMacro.h"


typedef NS_ENUM(NSInteger, CATPositionType) {
    /// image on left, text on right
    CATPositionTypeLIRT = 0,
    /// text on left, image on right
    CATPositionTypeLTRI,
};


@interface CATNaviButtonItem ()

/// text label
@property (nonatomic, strong) UILabel *textLabel;
/// image view
@property (nonatomic, strong) UIImageView *iconView;
/// content view
@property (nonatomic, strong) UIView *contentView;


/// text and icon margin, == 3
@property (nonatomic, assign, readonly) CGFloat margin;

/// title
@property (nonatomic, copy) NSString *title;
/// image name
@property (nonatomic, copy) NSString *imageName;
/// button type
@property (nonatomic, assign) CATButtonType type;

/// postion type
@property (nonatomic, assign) CATPositionType positionType;


@end

@implementation CATNaviButtonItem


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createButtonWithTitle:nil imageName:nil buttonType:CATButtonTypeNormal];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName {
    return [self initWithTitle:title imageName:imageName buttonType:CATButtonTypeNormal];
}

- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title {
    return [self initWithImageName:imageName title:title buttonType:CATButtonTypeNormal];
}

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName buttonType:(CATButtonType)buttonType {
    if (self = [super init]) {
        self.positionType = CATPositionTypeLTRI;
        [self createButtonWithTitle:title imageName:imageName buttonType:CATButtonTypeNormal];
    }
    return self;
}

- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title buttonType:(CATButtonType)buttonType {
    if (self = [super init]) {
        self.positionType = CATPositionTypeLIRT;
        [self createButtonWithTitle:title imageName:imageName buttonType:CATButtonTypeNormal];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setupButtonType];
    
    CGFloat buttonWidth = self.width;
    if (buttonWidth < 0) buttonWidth = 0;
    CGFloat buttonHeight = self.height;
    if (buttonHeight < 0) buttonHeight = 0;
    
    self.contentView.height = buttonHeight;
    self.contentView.x = 0;
    
    if (self.textLabel && self.iconView) {
        // margin between icon and text
        CGFloat margin = self.margin;
        self.textLabel.height = self.contentView.height;
        self.textLabel.y = 0;
        self.iconView.centerY = self.contentView.height / 2.0;
        
        if (self.positionType == CATPositionTypeLIRT) {
            // left icon, right text
            self.iconView.x = 0;
            self.textLabel.x = self.iconView.right + margin;
        } else {
            // left text, right icon
            self.textLabel.x = 0;
            self.iconView.x = self.textLabel.right + margin;
        }
    } else {
        if (self.textLabel) {
            // text width
            self.textLabel.height = self.contentView.height;
        } else if (self.iconView) {
            self.iconView.centerY = self.contentView.height / 2.0;
        } else {
            // all sub view is hidden
        }
    }
    
    if (self.type == CATButtonTypeNormal) {
        if (self.naviSide == CATNavigationSideLeft) {
            // 居左
            self.contentView.x = 0;
        } else {
            // 居右
            self.contentView.right = self.width;
        }
    } else {
        // 居中
        self.contentView.centerX = self.width / 2.0;
    }
}

#pragma mark - Private
- (void)createButtonWithTitle:(NSString *)title imageName:(NSString *)imageName buttonType:(CATButtonType)buttonType {
    self.title = title;
    self.imageName = imageName;
    self.type = CATButtonTypeNormal;
    _margin = 3;
    
    self.clipsToBounds = YES;
    self.exclusiveTouch = YES;
    
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor clearColor];
    contentView.userInteractionEnabled = NO;
    [self addSubview:contentView];
    self.contentView = contentView;
    if (title.length) {
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.text = title;
        textLabel.font = [UIFont systemFontOfSize:16];
        textLabel.textColor = [UIColor colorWithHexString:@"0x181818"];
        textLabel.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:textLabel];
        self.textLabel = textLabel;
    }
    
    if (imageName.length) {
        UIImage *icon = [UIImage imageNamed:imageName];
        if (icon) {
            UIImageView *iconView = [[UIImageView alloc] initWithImage:icon];
            iconView.backgroundColor = [UIColor clearColor];
            [contentView addSubview:iconView];
            self.iconView = iconView;
        }
    }
    
    // 设置默认宽度
    if (self.textLabel && self.iconView) {
        CGFloat textWidth = [self.textLabel.text cat_widthWithFont:self.textLabel.font];
        self.textLabel.width = textWidth;
        self.width = textWidth + self.margin + self.iconView.width;
    } else {
        if (self.textLabel) {
            CGFloat textWidth = [self.textLabel.text cat_widthWithFont:self.textLabel.font];
            self.textLabel.width = textWidth;
            self.width = textWidth;
        } else if (self.iconView) {
            self.width = self.iconView.width;
        } else {
            // all sub view is hidden
        }
    }
    self.contentView.width = self.width;
}

- (void)setupButtonType {
    switch (self.type) {
        case CATButtonTypeCircleColor:
            self.backgroundColor = [UIColor yellowColor];
            self.layer.cornerRadius = CGRectGetHeight(self.frame) / 2.f;
            break;
        case CATButtonTypeCircleLayer:
            self.backgroundColor = [UIColor clearColor];
            self.layer.cornerRadius = CGRectGetHeight(self.frame) / 2.f;
            self.layer.borderColor = [UIColor colorWithHexString:@"0x666666"].CGColor;
            self.layer.borderWidth = 1.0 / [UIScreen mainScreen].scale;
            break;
        default:
            self.backgroundColor = [UIColor redColor];
            self.layer.cornerRadius = 0.f;
            break;
    }
}

#pragma mark - Public

@end
