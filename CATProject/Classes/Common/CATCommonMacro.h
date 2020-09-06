//
//  CATCommonMacro.h
//  CATProject
//
//  Created by Shihuaixing on 2020/9/2.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#ifndef CATCommonMacro_h
#define CATCommonMacro_h

// RGBA颜色
#define COLOR_HEX_ALPHA(hexString, alpha) [UIColor colorWithRed:((float)((hexString & 0xFF0000) >> 16)) / 255.0 green:((float)((hexString & 0xFF00) >> 8)) / 255.0 blue:((float)(hexString & 0xFF)) / 255.0 alpha:alpha]

// RGB颜色
#define COLOR_HEX(hexString)                [UIColor colorWithRed:((float)((hexString & 0xFF0000) >> 16)) / 255.0 green:((float)((hexString & 0xFF00) >> 8)) / 255.0 blue:((float)(hexString & 0xFF)) / 255.0 alpha:1]

// controller common color
#define COLOR_COMMON_CONTROLLER             [UIColor colorWithRed:((float)((0xF5F5F5 & 0xFF0000) >> 16)) / 255.0 green:((float)((0xF5F5F5 & 0xFF00) >> 8)) / 255.0 blue:((float)(0xF5F5F5 & 0xFF)) / 255.0 alpha:1]

#endif /* CATCommonMacro_h */
