//
//  NSYNETDownloadFilePlugin.h
//  Hello World
//
//  Created by wujiang on 15/9/30.
//
//

#import <Cordova/CDV.h>

@interface NSYNETDownloadFilePlugin : CDVPlugin

/**
 *	@brief	文件下载
 *
 *	@param 	arguments 	参数数组
 *	@param 	options 	参数字典
 */
- (void)downloadFile:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end
