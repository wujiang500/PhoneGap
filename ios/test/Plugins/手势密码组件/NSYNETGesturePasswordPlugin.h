//
//  NSYNETGesturePasswordPlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/15.
//
//

#import <Cordova/CDV.h>

@interface NSYNETGesturePasswordPlugin : CDVPlugin



/**
 *	@brief	手势密码锁
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)gesturePassword:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


@end
