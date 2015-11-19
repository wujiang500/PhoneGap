//
//  NSYNETNativeHtmlSwitchPlugin.h
//  test
//
//  Created by wujiang on 15/10/23.
//
//

#import <Cordova/CDV.h>

@interface NSYNETNativeHtmlSwitchPlugin : CDVPlugin

/**
 *  原生与H5相互跳转
 *
 *  @param arguments 参数数组
 *  @param options   参数字典
 */
- (void)htmlToNative:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end
