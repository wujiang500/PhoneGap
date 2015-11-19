//
//  NSYNETCheckAPPExistPlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/10.
//
//

#import "NSYNETCheckAPPExistPlugin.h"

@interface NSYNETCheckAPPExistPlugin () 
@property (nonatomic, copy)  NSString *callBackIDString;
@end

@implementation NSYNETCheckAPPExistPlugin

- (void)checkAppExist:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    if(arguments.count > 0)
    {
        self.callBackIDString  = [arguments objectAtIndex:0];
        
        NSString *appURLStr = [NSString stringWithFormat:@"%@://",[arguments objectAtIndex:1]];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appURLStr]])
        {
            CDVPluginResult *result = nil;
            NSString *returnStr = @"0";
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:returnStr];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
        }
        else
        {
            CDVPluginResult *result = nil;
            NSString *returnStr = @"1";
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:returnStr];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
        }
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIDString];
    }
   
}

@end
