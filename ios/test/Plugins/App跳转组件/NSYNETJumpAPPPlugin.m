//
//  NSYNETJumpAPPPlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/12.
//
//

#import "NSYNETJumpAPPPlugin.h"

@interface NSYNETJumpAPPPlugin ()

@property (nonatomic,copy) NSString * callBackIDString;

@end

@implementation NSYNETJumpAPPPlugin

- (void)jumpApp:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    if(arguments.count > 1)
    {
        self.callBackIDString = [arguments objectAtIndex:0];
        NSString *APPID = [arguments objectAtIndex:1];
        
        NSString *param = nil;
        if ([arguments count] > 2)
        {
            param = [arguments objectAtIndex:2];
        }
        
        NSString *urlStr = [NSString stringWithFormat:@"%@://%@",APPID,param == nil ? @"" : param];
        NSURL *myUrl = [NSURL URLWithString:urlStr];
        
        
        CDVPluginResult *result = nil;
        if([[UIApplication sharedApplication] canOpenURL:myUrl])
        {
            BOOL  isOpen =  [[UIApplication sharedApplication] openURL:myUrl];
            if(isOpen)
            {
                NSString *returnStr = @"0";
                result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:returnStr];
                [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
            }
        }
        else
        {
            NSString *returnStr = @"1";
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:returnStr];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
        }
    }else{
        CDVPluginResult * result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
    }
}

@end
