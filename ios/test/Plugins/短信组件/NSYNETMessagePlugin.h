//
//  NSYNETMessagePlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/14.
//

#import <Cordova/CDV.h>

@interface NSYNETMessagePlugin : CDVPlugin


/**
 *	@brief	发送短信
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)sendMessage:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


@end
