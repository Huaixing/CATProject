//
//  CATNaviButtonItem.h
//  CATProject
//
//  Created by Shihuaixing on 2020/9/4.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 按钮的样式（back color、layer等）
typedef NS_ENUM(NSInteger, CATButtonType) {
    /// normal button,clear color
    CATButtonTypeNormal = 0,
    /// clear color and circle layer button
    CATButtonTypeCircleLayer = 1,
    /// yellow back color and circle
    CATButtonTypeCircleColor = 2,
};

/// 按钮的位置，在导航栏的左边还是右边
typedef NS_ENUM(NSInteger, CATNavigationSide) {
    /// left on navibar
    CATNavigationSideLeft = 0,
    /// right on navibar
    CATNavigationSideRight = 1,
};



@interface CATNaviButtonItem : UIButton

/// 导航栏按钮在导航栏哪一边
@property (nonatomic, assign) CATNavigationSide naviSide;

/// button
/// @param imageName left image
/// @param title right title
- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title;

/// button
/// @param imageName left imae
/// @param title right title
/// @param buttonType button type
- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title buttonType:(CATButtonType)buttonType;


/// button
/// @param title left title
/// @param imageName right image
- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName;

/// button
/// @param title left title
/// @param imageName right image
/// @param buttonType button type
- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName buttonType:(CATButtonType)buttonType;
@end


