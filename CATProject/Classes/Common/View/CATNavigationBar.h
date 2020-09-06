//
//  CATNavigationBar.h
//  CATProject
//
//  Created by Shihuaixing on 2020/9/3.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CATNaviButtonItem;


@interface CATNavigationBar : UIView

/// left item
@property (nonatomic, strong) CATNaviButtonItem *leftButtonItem;
/// right item
@property (nonatomic, strong) CATNaviButtonItem *rightButtonItem;

/// navigation bar title
@property (nonatomic, copy) NSString *title;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;



@end


