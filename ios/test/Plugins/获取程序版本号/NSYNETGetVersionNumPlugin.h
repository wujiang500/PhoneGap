//
//  NSYNETGetVersionNumPlugin.h
//  test
//
//  Created by wujiang on 15/10/21.
//
//

#import <Cordova/CDV.h>

@interface NSYNETGetVersionNumPlugin : CDVPlugin

/**
 *  获取版本号
 *
 *  @param arguments 参数数组
 *  @param options   参数字典
 */
- (void)getVersionNum:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;



@end
