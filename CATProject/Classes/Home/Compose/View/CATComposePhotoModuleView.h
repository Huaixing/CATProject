//
//  CATComposePhotoModuleView.h
//  CATProject
//
//  Created by Shihuaixing on 2020/9/15.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CATPhotoKit/CATPhotoKit.h>

@protocol CATComposePhotoModuleViewDelegate <NSObject>

@optional

@end


/// image view
@interface CATComposePhotoView : UIImageView

/// photo
@property (nonatomic, strong) CATPhoto *photo;

@end


/// photo module view
@interface CATComposePhotoModuleView : UIView

/// delegate
@property (nonatomic, weak) id<CATComposePhotoModuleViewDelegate> delegate;


/// Init
- (instancetype)initWithDelegate:(id<CATComposePhotoModuleViewDelegate>)delegate;
@end


