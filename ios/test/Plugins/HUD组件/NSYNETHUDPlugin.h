//
//  NSYNETHUDPlugin.h
//  test
//
//  Created by wujiang on 15/10/21.
//
//

#import <Cordova/CDV.h>

@interface NSYNETHUDPlugin : CDVPlugin

/**
 *  显示hud
 *
 *  @param arguments 参数数组
 *  @param options   参数字典
 */
- (void)waitingHud:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;



/**
 *  隐藏所有hud(小菊花转圈圈)
 *
 *  @param arguments 参数数组
 *  @param options   参数字典
 */
- (void)hideAllHud:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


@end
