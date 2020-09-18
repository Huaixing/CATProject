//
//  CATComposePhotoModuleView.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/15.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATComposePhotoModuleView.h"

@implementation CATComposePhotoModuleView

- (instancetype)initWithDelegate:(id<CATComposePhotoModuleViewDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
    }
    return self;
}



@end
