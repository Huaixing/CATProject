//
//  CATComposePhotoModuleView.h
//  CATProject
//
//  Created by Shihuaixing on 2020/9/15.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CATComposePhotoModuleViewDelegate <NSObject>

@optional

@end

@interface CATComposePhotoModuleView : UIView

/// delegate
@property (nonatomic, weak) id<CATComposePhotoModuleViewDelegate> delegate;


/// Init
- (instancetype)initWithDelegate:(id<CATComposePhotoModuleViewDelegate>)delegate;
@end


