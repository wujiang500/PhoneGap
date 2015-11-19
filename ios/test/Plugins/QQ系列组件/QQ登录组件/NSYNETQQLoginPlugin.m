//
//  NSYNETQQLoginPlugin.m
//  test
//
//  Created by wujiang on 15/10/27.
//
//

#import "NSYNETQQLoginPlugin.h"
#import <TencentOpenAPI/TencentApiInterface.h>
#import "AppDelegate.h"
#import "JSONKit.h"
#import <TencentOpenAPI/sdkdef.h>


@interface NSYNETQQLoginPlugin () <TencentSessionDelegate , TencentLoginDelegate>

@property (nonatomic, copy) NSString * callBackIdString;
@property (nonatomic, retain) TencentOAuth * tencentOAuth;


@end

@implementation NSYNETQQLoginPlugin

- (void)QQLogin:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    if(arguments.count > 0 )
    {
        self.callBackIdString = [arguments objectAtIndex:0];
        
        BOOL isInstallQQ = [TencentOAuth iphoneQQInstalled];
        if(isInstallQQ)
        {
            self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:TENCENT_APP_ID andDelegate:self];
            self.tencentOAuth.redirectURI = @"www.qq.com";
            
            NSArray * permissions = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil];
            
            [self.tencentOAuth authorize:permissions inSafari:NO];
        
        }else{
            
            CDVPluginResult *result = nil;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"没有安装QQ"];
            [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
        }
        
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
    }
}

- (void)tencentDidLogin
{
    NSString * message = @"";
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length]){
        //  记录登录用户的OpenID、Token以及过期时间
        message = _tencentOAuth.accessToken;
       
        [self.tencentOAuth getUserInfo]; // 登录成功获取用户信息

    }else{
        message = @"登录不成功 没有获取accesstoken";
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:message];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
    }
}

-(void)tencentDidNotLogin:(BOOL)cancelled
{
    NSString * message = @"";
    if (cancelled){
        message = @"用户取消登录";
    }else{
        message = @"登录失败";
    }
    
    CDVPluginResult *result = nil;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:message];
    [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
}

-(void)tencentDidNotNetWork
{
    NSString *  message = @"无网络连接，请设置网络";
    CDVPluginResult *result = nil;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:message];
    [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
}


-(void)getUserInfoResponse:(APIResponse *)response
{
    NSDictionary  * messageDict  = response.jsonResponse;
    NSString * message = [messageDict JSONString];
    
    CDVPluginResult *result = nil;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
}


@end
