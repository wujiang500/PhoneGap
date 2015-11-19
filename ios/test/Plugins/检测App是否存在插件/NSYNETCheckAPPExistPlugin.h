//
//  NSYNETCheckAPPExistPlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/10.
//
//

#import <Cordova/CDV.h>



@interface NSYNETCheckAPPExistPlugin : CDVPlugin

/**
 *  检测APP是否存在
 *
 *  @param arguments 参数数组
 *  @param options   参数字典
 */
- (void)checkAppExist:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end
