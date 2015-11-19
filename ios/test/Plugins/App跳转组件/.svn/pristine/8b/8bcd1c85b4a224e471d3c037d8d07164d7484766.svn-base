//
//  NSMeapJumpAPPPlugin.m
//  Cordova_TEST
//
//  Created by Yalin on 14-3-20.
//
//

#import "NSMeapJumpAPPPlugin.h"

@implementation NSMeapJumpAPPPlugin

/**
 *  跳转接口
 *
 *  @param arguments 传参 [应用ID,附带参数]
 *  @param options   配置
 */
- (void)jumpApp:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    NSString *callBackID = [arguments objectAtIndex:0];
    
    NSString *APPID = [arguments objectAtIndex:1];
    
    NSString *param = nil;
    if ([arguments count] > 2)
    {
        param = [arguments objectAtIndex:2];
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@://%@",APPID,param == nil ? @"" : param];
    NSURL *myUrl = [NSURL URLWithString:urlStr]; //xxxApp为目标App跳转的key
    
    CDVPluginResult *result = nil;
    
    if([[UIApplication sharedApplication] canOpenURL:myUrl])
    {
        NSString *returnStr = @"0";
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:returnStr];
        [self success:result callbackId:callBackID];
        
        [[UIApplication sharedApplication] openURL:myUrl];
        
    }
    else
    {
        NSString *returnStr = @"1";
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:returnStr];
        [self error:result callbackId:callBackID];
    }
    
}

@end
