//
//  NSYNETAlipayPlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/22.
//
//

#import <Cordova/CDV.h>

@interface NSYNETAlipayPlugin : CDVPlugin

/**
 *	@brief	支付宝支付
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)AliPay:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


@end
