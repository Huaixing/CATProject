//
//  CATNavigationController.h
//  CATProject
//
//  Created by Shihuaixing on 2020/9/1.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CATNavigationBar;


@interface CATNavigationController : UINavigationController
/// custom navigation bar
@property (nonatomic, strong, readonly) CATNavigationBar *navigatorBar;

@end

