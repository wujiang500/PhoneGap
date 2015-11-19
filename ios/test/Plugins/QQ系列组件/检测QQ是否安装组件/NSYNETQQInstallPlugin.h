//
//  NSYNETQQInstallPlugin.h
//  test
//
//  Created by wujiang on 15/10/27.
//
//

#import <Cordova/CDV.h>

@interface NSYNETQQInstallPlugin : CDVPlugin

/**
 *	@brief	QQ是否安装
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)QQInstall:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;



@end
