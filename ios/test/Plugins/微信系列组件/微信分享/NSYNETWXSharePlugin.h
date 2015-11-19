//
//  NSYNETWXSharePlugin.h
//  test
//
//  Created by wujiang on 15/10/20.
//
//

#import <Cordova/CDV.h>

@interface NSYNETWXSharePlugin : CDVPlugin

/**
 *	@brief	分享微信好友
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)wxShareToFriends:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


/**
 *	@brief	分享微信朋友圈
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)wxShareToCircleFriends:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;







@end
