//
//  NSYNETJumpAPPPlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/12.
//
//

#import <Cordova/CDV.h>

@interface NSYNETJumpAPPPlugin : CDVPlugin

/**
 *  App跳转
 *
 *  @param arguments 参数数组
 *  @param options   参数字典
 */
- (void)jumpApp:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end
