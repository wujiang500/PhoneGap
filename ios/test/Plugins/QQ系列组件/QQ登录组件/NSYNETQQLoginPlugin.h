//
//  NSYNETQQLoginPlugin.h
//  test
//
//  Created by wujiang on 15/10/27.
//
//

#import <Cordova/CDV.h>

@interface NSYNETQQLoginPlugin : CDVPlugin

/**
 *	@brief	QQ登录
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)QQLogin:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end
