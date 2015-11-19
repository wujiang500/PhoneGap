//
//  NSYNETNativeHtmlSwitchPlugin.m
//  test
//
//  Created by wujiang on 15/10/23.
//
//

#import "NSYNETNativeHtmlSwitchPlugin.h"
#import "AppDelegate.h"

@interface NSYNETNativeHtmlSwitchPlugin ()

@property (nonatomic, copy) NSString * callBackIdString;

@end

@implementation NSYNETNativeHtmlSwitchPlugin


- (void)htmlToNative:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    if(arguments.count >= 2)
    {
        self.callBackIdString = [arguments objectAtIndex:0];
        NSString *viewControllerName = [arguments objectAtIndex:1];
        id viewController = [[NSClassFromString(viewControllerName) alloc]init];
        
        if (viewController) {
            if ([viewController respondsToSelector:@selector(setInfo:)]) {
                [viewController performSelector:@selector(setInfo:) withObject:[arguments objectAtIndex:2]];
            }
            [(AppDelegate *)([[UIApplication sharedApplication] delegate]) window].rootViewController = viewController;
            CDVPluginResult *result = nil;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"页面跳转成功"];
            [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
        }else{
            CDVPluginResult *result = nil;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"没有这个viewController"];
            [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
        }
    }else{
    
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
    
    }
}

@end
