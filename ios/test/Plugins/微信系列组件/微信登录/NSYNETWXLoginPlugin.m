//
//  NSYNETWXLoginPlugin.m
//  test
//
//  Created by wujiang on 15/10/26.
//
//

#import "NSYNETWXLoginPlugin.h"
#import "WXApi.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"
#import "JSONKit.h"

@interface NSYNETWXLoginPlugin () <WXApiDelegate>

@property (nonatomic,copy) NSString * callBackIdString;


@end

@implementation NSYNETWXLoginPlugin
- (void)wxLogin:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    if(arguments.count > 0)
    {
        self.callBackIdString = [arguments objectAtIndex:0];
        
        //构造SendAuthReq结构体
        SendAuthReq* req =[[SendAuthReq alloc ] init ] ;
        req.scope = @"snsapi_userinfo" ;
        req.state = @"123" ;
        //第三方向微信终端发送一个SendAuthReq消息结构
        [WXApi sendReq:req];
    }else{
        
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];
    }
}

- (void)onResp:(BaseResp *)resp
{
     if([resp isKindOfClass:[SendAuthResp class]])
     {
         NSNumber *code = @(resp.errCode);
         if([code isEqual:@(0)])
         {
             NSURL *url = [NSURL URLWithString:[WEIXIN_getTocken(((SendAuthResp *)resp).code) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
             NSURLRequest *request = [NSURLRequest requestWithURL:url];
             AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request];
             [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                 NSData* data=[operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
                 NSDictionary *dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                 NSLog(@"dict：%@",dict);
                 NSURL *url1 = [NSURL URLWithString:[WEIXIN_getInfo(dict[@"access_token"],dict[@"openid"]) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                 NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
                 AFHTTPRequestOperation *operation11 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
                 [operation11 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation2, id responseObject) {
                     
                     NSData* data1=[operation2.responseString dataUsingEncoding:NSUTF8StringEncoding];
                     NSDictionary* dict1=[NSJSONSerialization  JSONObjectWithData:data1 options:0 error:nil];
                     NSLog(@"dict1：%@",dict1);
                     
                     if(dict1)
                     {
                         CDVPluginResult *result = nil;
                         result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[dict1 JSONString]];
                         [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];
                     }
                 } failure:^(AFHTTPRequestOperation *operation2, NSError *error) {
                     
                     CDVPluginResult *result = nil;
                     result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"登录失败"];
                     [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];
                 }];
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 
                 CDVPluginResult *result = nil;
                 result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"登录失败"];
                 [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];
             }];
         }
     }
}



@end
