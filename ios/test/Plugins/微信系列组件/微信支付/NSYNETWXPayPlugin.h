//
//  NSYNETWXPayPlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/19.
//
//

#import <Cordova/CDV.h>

@interface NSYNETWXPayPlugin : CDVPlugin


/**
 *	@brief	微信支付
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)WXPay:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


@end
