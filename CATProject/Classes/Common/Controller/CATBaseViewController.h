//
//  CATBaseViewController.h
//  CATProject
//
//  Created by Shihuaixing on 2020/9/1.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CATCommonMacro.h"
#import "CATNaviButtonItem.h"

@class CATNavigationBar;


@interface CATBaseViewController : UIViewController

/// navigation bar
@property (nonatomic, strong, readonly) CATNavigationBar *navigationBar;

/// navigaiton bar title string
@property (nonatomic, copy) NSString *titleString;

/// left button item, default is back item, only black back icon
@property (nonatomic, strong) CATNaviButtonItem *leftNaviButtonItem;

/// right button item, default is nil
@property (nonatomic, strong) CATNaviButtonItem *rightNaviButtonItem;

- (void)cat_pushVieController:(CATBaseViewController *)controller animated:(BOOL)animated;


#pragma mark - Action
- (void)leftNaviButtonItemDidClick:(CATNaviButtonItem *)sender;

@end


