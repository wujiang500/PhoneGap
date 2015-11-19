//
//  UIColor+Fmb.m
//  fmb
//
//  Created by Xin Du on 5/14/14.
//  Copyright (c) 2014 Linktone. All rights reserved.
//

#import "UIColor+LTColor.h"

@implementation UIColor (LTColor)

+ (instancetype) lt_orangeRedColor{
  return [UIColor colorWithHexString:@"#ff6600"];
}

+ (instancetype) lt_orangeColor{
  return [UIColor colorWithHexString:@"#ff9933"];
}

+ (instancetype) lt_blackColor{
  return [UIColor colorWithHexString:@"#333333"];
}

+ (instancetype) lt_darkGrayColor{
  return [UIColor colorWithHexString:@"#666666"];
}

+ (instancetype) lt_lightGrayColor{
  return [UIColor colorWithHexString:@"#999999"];
}

+ (instancetype) lt_lightBlueColor{
  return [UIColor colorWithHexString:@"#5BB7DE"];
}

+ (instancetype) lt_darkBlueColor{
  return [UIColor colorWithHexString:@"0080b1"];
}

+ (CGColorRef)createRGBValue:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
  CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
  CGFloat components[4] = {red, green, blue, alpha};
  CGColorRef color = CGColorCreate(colorspace, components);
  CGColorSpaceRelease(colorspace);
  return color;
}

+ (instancetype)colorFromRGB:(NSInteger)rgbValue withAlpha:(CGFloat)alpha  {
  return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) /(float) 255.0
                         green:((float)((rgbValue & 0xFF00) >> 8)) /(float) 255.0
                          blue:((float)(rgbValue & 0xFF)) /(float) 255.0 alpha:alpha];
  
}

+ (instancetype)colorFromRGB:(NSInteger)rgbValue {
  return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) /(float) 255.0
                         green:((float)((rgbValue & 0xFF00) >> 8)) /(float)255.0
                          blue:((float)(rgbValue & 0xFF)) /(float)255.0 alpha:1.0];
  
}

/**
 * hexString eg. #ff0000
 */
+ (instancetype)colorWithHexString:(NSString *)hexString {
  return [UIColor colorWithHexString:hexString alpha:1.0];
}

/**
 * hexString eg. #ffffffff
 */
+ (instancetype)colorWithHexStringWithAlpha:(NSString*)hexString {
  if ([hexString hasPrefix:@"0x"] || [hexString hasPrefix:@"0X"]) {
    hexString = [hexString substringFromIndex:2];
	} else if ([hexString hasPrefix:@"#"]) {
    hexString = [hexString substringFromIndex:1];
  }
  
  unsigned int value = 0;
  BOOL flag = [[NSScanner scannerWithString:hexString] scanHexInt:&value];
  if(NO == flag)
    return [UIColor clearColor];
  float r, g, b, a;
  a = (value & 0x000000FF) / (float)255.0;
  value = value >> 8;
  b = value & 0x000000FF;
  value = value >> 8;
  g = value & 0x000000FF;
  value = value >> 8;
  r = value;
  
  return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

+ (instancetype)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
	if ([hexString hasPrefix:@"0x"] || [hexString hasPrefix:@"0X"]) {
    hexString = [hexString substringFromIndex:2];
	} else if ([hexString hasPrefix:@"#"]) {
    hexString = [hexString substringFromIndex:1];
  }
  
  unsigned int value = 0;
  BOOL flag = [[NSScanner scannerWithString:hexString] scanHexInt:&value];
  if(NO == flag)
    return [UIColor clearColor];
  CGFloat r, g, b, a;
  a = alpha;
  b = value & 0x0000FF;
  value = value >> 8;
  g = value & 0x0000FF;
  value = value >> 8;
  r = value;
  
  return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

@end
