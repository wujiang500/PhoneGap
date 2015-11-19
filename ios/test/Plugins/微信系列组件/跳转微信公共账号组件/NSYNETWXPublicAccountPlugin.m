//
//  NSYNETWXPublicAccountPlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/19.
//
//

#import "NSYNETWXPublicAccountPlugin.h"
#import "WXApi.h"
#import "WXApiObject.h"

@interface NSYNETWXPublicAccountPlugin () <WXApiDelegate>

@property (nonatomic,copy) NSString * callBackIdString;
@property (nonatomic,copy) NSString * UrlString;

@end

@implementation NSYNETWXPublicAccountPlugin

- (void)openPublicAccount:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    if(arguments.count > 1)
    {
        self.callBackIdString = [arguments objectAtIndex:0];
        self.UrlString = [arguments objectAtIndex:1];
        
        JumpToBizProfileReq *req = [[JumpToBizProfileReq alloc]init];
        req.profileType =WXBizProfileType_Normal;
        req.username = self.UrlString;   //公众号原始ID
        BOOL isOpen =  [WXApi sendReq:req];
        if(isOpen)
        {
            CDVPluginResult *result = nil;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"跳转成功"];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];
        }
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];
    }
}

@end
