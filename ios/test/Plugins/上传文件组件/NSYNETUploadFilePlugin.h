//
//  NSYNETUploadFilePlugin.h
//  Hello World
//
//  Created by wujiang on 15/9/30.
//
//

#import <Cordova/CDV.h>

@interface NSYNETUploadFilePlugin : CDVPlugin

/**
 *	@brief	文件上传
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)uploadFile:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end

