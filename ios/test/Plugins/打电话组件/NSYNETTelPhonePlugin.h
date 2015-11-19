//
//  NSYNETTelPhonePlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/14.
//
//

#import <Cordova/CDV.h>

@interface NSYNETTelPhonePlugin : CDVPlugin

/**
 *	@brief	打电话
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)callPhone:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end
