//
//  NSYNETRemCountPasswordPlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/14.
//
//

#import "NSYNETRemCountPasswordPlugin.h"
#import "SSKeychain.h"

@interface NSYNETRemCountPasswordPlugin () 

@property (nonatomic, copy) NSString * callBackIDString;
@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * password;

@end

static NSString *const kServiceKey = @"NSYNET";
static NSString *const kAccountKey = @"userId";
static NSString *const kPasswordKey = @"password";

@implementation NSYNETRemCountPasswordPlugin

- (void)remember:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    self.callBackIDString = [arguments objectAtIndex:0];
    if(arguments.count >= 2)
    {
        self.userName = [arguments objectAtIndex:1];
        self.password = [arguments objectAtIndex:2];
        
        BOOL isUserName = [SSKeychain setPassword:self.userName forService:kServiceKey account:kAccountKey];
        BOOL isPassword = [SSKeychain setPassword:self.password forService:kServiceKey account:kPasswordKey];
        if(isUserName && isPassword)
        {
            CDVPluginResult *resultDate = nil;
            resultDate = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"成功保存到钥匙串"];
            [self.commandDelegate sendPluginResult:resultDate callbackId:self.callBackIDString];
        }else{
            CDVPluginResult *result = nil;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"保存失败"];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
        }
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
    }
}

- (void)forget:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    self.callBackIDString = [arguments objectAtIndex:0];
    if(arguments.count > 0)
    {
        BOOL isUserName = [SSKeychain deletePasswordForService:kServiceKey account:kAccountKey];
        BOOL isPassword = [SSKeychain deletePasswordForService:kServiceKey account:kPasswordKey];
        
        if(isUserName && isPassword)
        {
            CDVPluginResult *resultDate = nil;
            resultDate = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"删除成功"];
            [self.commandDelegate sendPluginResult:resultDate callbackId:self.callBackIDString];
        }else{
            CDVPluginResult *result = nil;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"删除失败"];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
        }
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
    }
    
}

@end
