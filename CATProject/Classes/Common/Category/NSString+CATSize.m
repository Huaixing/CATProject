//
//  NSString+CATSize.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/4.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "NSString+CATSize.h"

@implementation NSString (CATSize)

- (CGSize)cat_sizeWithFont:(UIFont *)font textHeight:(CGFloat)textHeight {
    return [self cat_sizeWithFont:font textHeight:textHeight limitSize:CGSizeZero];
}

- (CGSize)cat_sizeWithFont:(UIFont *)font textHeight:(CGFloat)textHeight limitSize:(CGSize)limitSize {
    if (self.length == 0) {
        return CGSizeZero;
    }
    if (textHeight <= 0) {
        return CGSizeZero;
    }
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:self];
    [attText addAttribute:NSFontAttributeName value:(font ? font : [UIFont systemFontOfSize:16]) range:NSMakeRange(0, self.length)];
    [attText addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, self.length)];
    if (textHeight) {
        /// 行高
        [attText addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithDouble:(textHeight - font.lineHeight) / 4] range:NSMakeRange(0, self.length)];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.maximumLineHeight = textHeight;
        style.minimumLineHeight = textHeight;
        [attText addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.length)];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, limitSize.width, limitSize.height)];
    label.numberOfLines = 0;
    label.attributedText = attText;
    [label sizeToFit];
    
    CGSize size = CGSizeMake(ceil(label.frame.size.width), ceil(label.frame.size.height));
    return size;
}

@end
