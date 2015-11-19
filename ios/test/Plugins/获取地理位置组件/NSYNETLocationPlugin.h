//
//  NSYNETLocationPlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/14.
//
//

#import <Cordova/CDV.h>

@interface NSYNETLocationPlugin : CDVPlugin


/**
 *	@brief	定位地理位置
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)userLocation:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end
