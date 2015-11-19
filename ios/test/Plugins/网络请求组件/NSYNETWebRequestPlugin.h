//
//  NSYNETWebRequestPlugin.h
//  Hello World
//
//  Created by wujiang on 15/9/30.
//
//

#import <Cordova/CDV.h>

@interface NSYNETWebRequestPlugin : CDVPlugin

/**
 *	@brief	网络请求
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)httpRequest:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end
