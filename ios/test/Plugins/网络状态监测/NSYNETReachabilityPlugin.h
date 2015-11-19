//
//  NSYNETReachabilityPlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/13.
//
//

#import <Cordova/CDV.h>

@interface NSYNETReachabilityPlugin : CDVPlugin

/**
 *	@brief	判断网络状态
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)isNetConnect:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


@end
