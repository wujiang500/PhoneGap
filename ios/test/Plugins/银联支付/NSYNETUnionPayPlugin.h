//
//  NSYNETUnionPayPlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/20.
//
//

#import <Cordova/CDV.h>

@interface NSYNETUnionPayPlugin : CDVPlugin

/**
 *	@brief	银联支付
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)UnionPay:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end
