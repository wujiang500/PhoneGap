//
//  NSYNETScanOfficeFilePlugin.h
//  Hello World
//
//  Created by wujiang on 15/10/11.
//
//

#import <Cordova/CDV.h>

@interface NSYNETScanOfficeFilePlugin : CDVPlugin

/**
 *  浏览Office文档
 *
 *  @param arguments 参数数组
 *  @param options   参数字典
 */
- (void)scanOfficeFile:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end
