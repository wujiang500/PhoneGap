//
//  NSYNETWXLoginPlugin.h
//  test
//
//  Created by wujiang on 15/10/26.
//
//

#import <Cordova/CDV.h>

@interface NSYNETWXLoginPlugin : CDVPlugin




/**
 *	@brief	微信登录
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)wxLogin:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


@end
