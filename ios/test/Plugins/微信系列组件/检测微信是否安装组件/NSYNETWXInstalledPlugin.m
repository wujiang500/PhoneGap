//
//  NSYNETWXInstalledPlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/19.
//
//

#import "NSYNETWXInstalledPlugin.h"
#import "WXApi.h"

@interface NSYNETWXInstalledPlugin ()

@property (nonatomic, copy) NSString * callBackIDString;

@end

@implementation NSYNETWXInstalledPlugin

- (void)isWXinstalled:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{

    if(arguments.count > 0)
    {
        self.callBackIDString = [arguments objectAtIndex:0];
        
        NSString * message = @"";
        if( [WXApi isWXAppInstalled])
        {
            message = @"微信已经安装";
         
        }else{
            message = @"微信尚未安装";
        }
       
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];

    }else{
    
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
    }
    
}


@end
