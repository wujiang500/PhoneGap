//
//  NSYNETKillAPPPlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/08.
//
//

#import <Cordova/CDV.h>

@interface NSYNETKillAPPPlugin : CDVPlugin

/**
 *  杀掉程序
 *
 *  @param arguments 参数数组
 *  @param options   参数字典
 */
- (void)killApp:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end
