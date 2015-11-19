//
//  NSYNETRemCountPasswordPlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/14.
//
//

#import <Cordova/CDV.h>

@interface NSYNETRemCountPasswordPlugin : CDVPlugin

/**
 *	@brief	记录用户名密码
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)remember:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


/**
 *	@brief	忘记用户名密码
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)forget:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


@end
