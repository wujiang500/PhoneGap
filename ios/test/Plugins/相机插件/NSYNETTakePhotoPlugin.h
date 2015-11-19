//
//  NSYNETTakePhotoPlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/09.
//
//

#import <Cordova/CDV.h>

@interface NSYNETTakePhotoPlugin : CDVPlugin

/**
 *	@brief	照相
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 *
 *	@return	NULL
 */
- (void)takePhoto:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end
