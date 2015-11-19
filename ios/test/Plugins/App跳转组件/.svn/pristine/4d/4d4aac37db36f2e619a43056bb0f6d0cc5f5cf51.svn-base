//
//  NSMeapJumpAPPPlugin.h
//  Cordova_TEST
//
//  Created by Yalin on 14-3-20.
//
//

/**
 * @file        NSMeapJumpAPPPlugin.h
 * @brief       应用跳转插件.
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
 *  程序跳转插件,如果需要使用该插件,注意对方的应用必须在xcode中的Info.plist进行配置,添加以下xml.
     <dict>
         <key>CFBundleTypeRole</key>
         <string>Editor</string>
         <key>CFBundleURLName</key>
         <string>应用ID</string>
         <key>CFBundleURLSchemes</key>
         <array>
             <string>应用ID</string>
         </array>
     </dict>
 */
@interface NSMeapJumpAPPPlugin : CDVPlugin

/**
 *  跳转接口
 *
 *  @param arguments 传参 [应用ID,附带参数]
 *  @param options   配置
 */
- (void)jumpApp:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;

@end
