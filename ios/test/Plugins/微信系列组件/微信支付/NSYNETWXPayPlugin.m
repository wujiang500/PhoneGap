//
//  NSYNETWXPayPlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/19.
//
//

#import "NSYNETWXPayPlugin.h"
#import "WXApiObject.h"
#import "WXApi.h"

@interface NSYNETWXPayPlugin () <WXApiDelegate>

@property (nonatomic,copy) NSString * callBackIdString;


@property (nonatomic, retain) NSDictionary * parametersDict;
@property (nonatomic, copy) NSString * urlString;
@property (nonatomic, copy) NSString * contentType;

@end

@implementation NSYNETWXPayPlugin

- (void)WXPay:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    if(arguments.count > 0)
    {
        self.callBackIdString = [arguments objectAtIndex:0];
        self.parametersDict =  [arguments objectAtIndex:1];
        self.urlString =       [arguments objectAtIndex:2];
        self.contentType =     [arguments objectAtIndex:3];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:self.contentType]; //@"text/html"
        
        //发送请求
        [manager POST:self.urlString parameters:self.parametersDict success:^(AFHTTPRequestOperation *operation, NSDictionary *  responseObject) {
            NSLog(@"JSON:%@", responseObject);
            
            PayReq* req             = [[PayReq alloc] init];
            req.openID              = [responseObject objectForKey:@"appid"];
            req.partnerId           = [responseObject objectForKey:@"partnerid"];
            req.prepayId            = [responseObject objectForKey:@"prepayid"];
            req.nonceStr            = [responseObject objectForKey:@"noncestr"];
            req.timeStamp           = [[responseObject objectForKey:@"timestamp"] intValue];
            req.package             = [responseObject objectForKey:@"package"];
            req.sign                = [responseObject objectForKey:@"app_sign"];
            NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
            [WXApi sendReq:req];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            CDVPluginResult *result = nil;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error description]];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];
        }];

    }else{
       
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];
    }
}

// 此处需要协定支付协定, 需不需要确定对方收到款项后再提示成功? 如何刷结果? 几秒一次?

- (void)onResp:(BaseResp *)resp
{
    // 微信支付回调
    NSString * strTitle = nil;
    if([resp isKindOfClass:[PayResp class]])
    {
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode)
        {
            case WXSuccess:
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                [self resultWithString:@"支付成功"];
                break;
                
            default:
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                [self resultWithString:@"支付失败"];
                break;
        }
    }
}
- (void)resultWithString:(NSString *)resultString{
    
    CDVPluginResult *result = nil;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:resultString];
    [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];

}

@end
