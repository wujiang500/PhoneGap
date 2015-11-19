//
//  NSYNETGetTokenPlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/13.
//
//

#import <Cordova/CDV.h>

@interface NSYNETGetTokenPlugin : CDVPlugin


/**
 *	@brief	获取Token
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)deviceToken:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end
