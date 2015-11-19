
//
//  NSYNETQQInstallPlugin.m
//  test
//
//  Created by wujiang on 15/10/27.
//
//

#import "NSYNETQQInstallPlugin.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface NSYNETQQInstallPlugin ()

@property (nonatomic, copy) NSString * callBackIdString;

@end

@implementation NSYNETQQInstallPlugin
- (void)QQInstall:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    if(arguments.count > 0 )
    {
        self.callBackIdString = [arguments objectAtIndex:0];
        
        BOOL isInstallQQ = [TencentOAuth iphoneQQInstalled];
        if(isInstallQQ){
           
            CDVPluginResult *result = nil;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"QQ已经安装"];
            [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
        }else{
            
            CDVPluginResult *result = nil;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"QQ已经安装"];
            [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
        }
        
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
    }
}




@end
