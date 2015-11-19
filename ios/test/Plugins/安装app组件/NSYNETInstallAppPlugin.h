//
//  NSYNETInstallAppPlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/13.
//
//

#import <Cordova/CDV.h>

@interface NSYNETInstallAppPlugin : CDVPlugin

/**
 *  安装APP
 *
 *  @param arguments 参数数组
 *  @param options   参数字典
 */
- (void)installApp:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end
