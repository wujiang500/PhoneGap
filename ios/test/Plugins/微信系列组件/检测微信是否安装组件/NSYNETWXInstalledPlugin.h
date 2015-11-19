//
//  NSYNETWXInstalledPlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/19.
//
//

#import <Cordova/CDV.h>

@interface NSYNETWXInstalledPlugin : CDVPlugin


/**
 *	@brief	检测微信是否安装
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)isWXinstalled:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


@end
