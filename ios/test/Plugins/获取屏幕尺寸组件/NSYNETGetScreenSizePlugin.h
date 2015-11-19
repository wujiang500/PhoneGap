//
//  NSYNETGetScreenSizePlugin.h
//  test
//
//  Created by wujiang on 15/10/21.
//
//

#import <Cordova/CDV.h>

@interface NSYNETGetScreenSizePlugin : CDVPlugin

/**
 *  存储
 *
 *  @param arguments 参数数组
 *  @param options   参数字典
 */
- (void)getScreenSize:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


@end
