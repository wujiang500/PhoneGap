//
//  NSMeapScanOfficeFilePlugin.h
//  Cordova_TEST
//
//  Created by Yalin on 14-3-20.
//
//

/**
 * @file        NSMeapScanOfficeFilePlugin.h
 * @brief       浏览Office插件.
 * @version     1.0
 * @date        2014-3-20
 *
 * [2014-03-20] <杨亚霖> v1.0
 *
 * + v1.0版发布.
 *
 */

#import <Foundation/Foundation.h>
#import "CDVPlugin.h"

/**
 *  浏览Office插件
 */
@interface NSMeapScanOfficeFilePlugin : CDVPlugin

/// 回调用的ID
@property (nonatomic, retain) NSString      *callBackID;

/// 浏览控制器
@property (nonatomic, retain) UINavigationController    *navController;

/**
 *  浏览Office文档
 *
 *  @param arguments 传参 [文件路径]
 *  @param options   配置
 */
- (void)scanOfficeFile:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end
