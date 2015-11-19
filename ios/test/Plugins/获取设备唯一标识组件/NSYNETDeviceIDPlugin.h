//
//  NSYNETDeviceIDPlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/14.
//
//

#import <Cordova/CDV.h>

@interface NSYNETDeviceIDPlugin : CDVPlugin

/**
 *	@brief	获取设备唯一标识
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)getDeviceId:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


@end
