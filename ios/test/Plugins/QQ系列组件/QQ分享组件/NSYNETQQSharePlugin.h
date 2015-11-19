//
//  NSYNETQQSharePlugin.h
//  test
//
//  Created by wujiang on 15/10/27.
//
//

#import <Cordova/CDV.h>


@interface NSYNETQQSharePlugin : CDVPlugin

/**
 *	@brief	QQ空间分享
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)QQShareQZone:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;




@end
