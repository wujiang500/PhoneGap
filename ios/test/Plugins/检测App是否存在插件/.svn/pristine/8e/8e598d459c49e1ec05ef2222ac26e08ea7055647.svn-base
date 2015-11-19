//
//  NSMeapCheckAPPExistPlugin.m
//  Cordova_TEST
//
//  Created by Yalin on 14-3-21.
//
//

#import "NSMeapCheckAPPExistPlugin.h"

@implementation NSMeapCheckAPPExistPlugin

/**
 *  检测APP是否存在
 *
 *  @param arguments [应用URL_ID]
 *  @param options   配置
 */
- (void)checkAppExist:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    NSString *callBackID = [arguments objectAtIndex:0];
    NSString *appURLStr = [NSString stringWithFormat:@"%@://",[arguments objectAtIndex:1]];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appURLStr]])
    {
        CDVPluginResult *result = nil;
        NSString *returnStr = @"0";
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:returnStr];
        [self success:result callbackId:callBackID];
    }
    else
    {
        CDVPluginResult *result = nil;
        NSString *returnStr = @"1";
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:returnStr];
        [self error:result callbackId:callBackID];
    }
}

@end
