//
//  NSYNETWXPublicAccountPlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/19.
//
//

#import <Cordova/CDV.h>


@interface NSYNETWXPublicAccountPlugin : CDVPlugin

/**
 *	@brief	应用内打开微信公共账号
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)openPublicAccount:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end
