//
//  NSYNETInstallAppPlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/13.
//
//

#import "NSYNETInstallAppPlugin.h"

@interface NSYNETInstallAppPlugin ()

@property (nonatomic, copy) NSString * callBackID;

@end

@implementation NSYNETInstallAppPlugin

- (void)installApp:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    if(arguments.count >= 2)
    {
        self.callBackID = [arguments objectAtIndex:0];
        NSString *plistURL = [arguments objectAtIndex:1];
        
        NSString *urlstring = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@",plistURL];
        
        CDVPluginResult *result = nil;
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlstring]])
        {
            NSString *returnStr = @"0";
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:returnStr];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackID];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlstring]];
        }
        else
        {
            NSString *returnStr = @"1";
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:returnStr];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackID];
        }
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackID];
    }
    
}


@end
