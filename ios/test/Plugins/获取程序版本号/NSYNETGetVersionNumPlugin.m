//
//  NSYNETGetVersionNumPlugin.m
//  test
//
//  Created by wujiang on 15/10/21.
//
//

#import "NSYNETGetVersionNumPlugin.h"

@interface NSYNETGetVersionNumPlugin ()

@property (nonatomic, copy) NSString * callBackIdString;

@end

@implementation NSYNETGetVersionNumPlugin

- (void)getVersionNum:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{

    if(arguments.count > 0)
    {
        self.callBackIdString = [arguments objectAtIndex:0];
        
        NSString * versionStirng = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:versionStirng];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
        
        
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
    }

}

@end
