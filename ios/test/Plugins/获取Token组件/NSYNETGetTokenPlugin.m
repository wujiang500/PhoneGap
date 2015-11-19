//
//  NSYNETGetTokenPlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/13.
//
//

#import "NSYNETGetTokenPlugin.h"

@interface NSYNETGetTokenPlugin () 

@property (nonatomic, copy) NSString * callBackID;

@end

@implementation NSYNETGetTokenPlugin

- (void)deviceToken:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    if (arguments.count > 0)
    {
        self.callBackID = [arguments objectAtIndex:0];
    
        CDVPluginResult *result = nil;
        
        NSString *deviceTokenStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"Token"];
        if (deviceTokenStr)
        {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:deviceTokenStr];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackID];
        }
        else
        {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"deviceToken获取失败"];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackID];
        }
    
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackID];
    }
  
}

@end
