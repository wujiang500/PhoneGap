//
//  UIColor+Fmb.h
//  fmb
//
//  Created by Xin Du on 5/14/14.
//  Copyright (c) 2014 Linktone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LTColor)

+ (instancetype) lt_orangeRedColor;//#ff6600
+ (instancetype) lt_orangeColor;//#ff9933
+ (instancetype) lt_blackColor;//#333333
+ (instancetype) lt_darkGrayColor;//#666666
+ (instancetype) lt_lightGrayColor;//#999999
+ (instancetype) lt_lightBlueColor;//#5BB7DE
+ (instancetype) lt_darkBlueColor;//#0080b1

+ (instancetype)colorFromRGB:(NSInteger)rgbValue withAlpha:(CGFloat)alpha;
+ (instancetype)colorFromRGB:(NSInteger)rgbValue;
+ (instancetype)colorWithHexString:(NSString *)hexString;
+ (instancetype)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
+ (instancetype)colorWithHexStringWithAlpha:(NSString *)hexString;


@end
