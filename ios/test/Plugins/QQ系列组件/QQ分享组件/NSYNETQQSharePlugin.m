//
//  NSYNETQQSharePlugin.m
//  test
//
//  Created by wujiang on 15/10/27.
//
//

#import "NSYNETQQSharePlugin.h"
#import <TencentOpenAPI/TencentMessageObject.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "TencentOpenAPI/QQApiInterface.h"

@interface NSYNETQQSharePlugin ()

@property (nonatomic, copy) NSString * callBackIdString;

@property (nonatomic, copy) NSString * titleString;
@property (nonatomic, copy) NSString * urlString;
@property (nonatomic, copy) NSString * contentString;
@property (nonatomic, copy) NSString * preViewImageUrlStr;

@end

@implementation NSYNETQQSharePlugin

- (void)QQShareQZone:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    if(arguments.count > 4 )
    {
        self.callBackIdString = [arguments objectAtIndex:0];
        self.titleString = [arguments objectAtIndex:1];
        self.urlString = [arguments objectAtIndex:2];
        self.contentString = [arguments objectAtIndex:3];
        self.preViewImageUrlStr = [arguments objectAtIndex:4];

        [self sendToQZone];
        
    }else{
        
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
    }
}

- (void)sendToQZone
{
  
    QQApiNewsObject* imgObj = [QQApiNewsObject objectWithURL:self.urlString  title:self.titleString description:self.contentString previewImageURL:self.preViewImageUrlStr];
    
    [imgObj setCflag:kQQAPICtrlFlagQZoneShareOnStart];
    
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:imgObj];
    
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    
    [self handleSendResult:sent];

    

}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    NSString * resultString = @"";
    switch (sendResult)
    {
        case EQQAPISENDSUCESS:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Success" message:@"分享成功" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            resultString = @"分享成功";
            
            break;
        }
            
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            resultString = @"错误,App未注册";

            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            resultString = @"错误,发送参数错误";

            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装QQ" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            resultString = @"错误,未安装QQ";

            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"访问接口错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            resultString = @"错误,访问接口错误";

            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            
            resultString = @"错误,消息发送失败";

            break;
        }
        default:
        {
            break;
        }
    }
    CDVPluginResult *result = nil;
    if([resultString isEqualToString:@"分享成功"])
    {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:resultString];
    }
    else
    {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:resultString];
    }
    [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
}


@end
