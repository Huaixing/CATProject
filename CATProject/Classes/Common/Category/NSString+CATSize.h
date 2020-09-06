//
//  NSString+CATSize.h
//  CATProject
//
//  Created by Shihuaixing on 2020/9/4.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (CATSize)

- (CGSize)cat_sizeWithFont:(UIFont *)font textHeight:(CGFloat)textHeight;
- (CGSize)cat_sizeWithFont:(UIFont *)font textHeight:(CGFloat)textHeight limitSize:(CGSize)limitSize;

@end


