//
//  NSYNETWXSharePlugin.m
//  test
//
//  Created by wujiang on 15/10/20.
//
//

#import "NSYNETWXSharePlugin.h"
#import "WXApi.h"
#import "WXApiObject.h"

@interface NSYNETWXSharePlugin () <WXApiDelegate>

@property (nonatomic, copy) NSString *  callBackIdString;
@property (nonatomic, copy) NSString * shareType; // 0-微信朋友; 1-朋友圈
@property (nonatomic, copy) NSString * shareTitle; // 分享标题
@property (nonatomic, copy) NSString * detailInfo; // 详细信息
@property (nonatomic, retain) NSString * shareImageURL; // ImageURL

@end

@implementation NSYNETWXSharePlugin

- (void)wxShareToFriends:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    if(arguments.count > 0)
    {
        self.callBackIdString  =[arguments objectAtIndex:0];
        
        self.shareType = [arguments objectAtIndex:1];
        self.shareTitle = [arguments objectAtIndex:2];
        self.detailInfo = [arguments objectAtIndex:3];
        self.shareImageURL = [arguments objectAtIndex:4];
        
        [self shareInformationWithType:[self.shareType integerValue]];
        
    }else{
        
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];
        
    }
}

- (void)wxShareToCircleFriends:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)option{
    if(arguments.count > 0)
    {
        self.callBackIdString  =[arguments objectAtIndex:0];
        
        self.shareType = [arguments objectAtIndex:1];
        self.shareTitle = [arguments objectAtIndex:2];
        self.detailInfo  = [arguments objectAtIndex:3];
        self.shareImageURL = [arguments objectAtIndex:4];
        
        [self shareInformationWithType:[self.shareType integerValue]];
        
    }else{
        
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];
        
    }
}

#pragma mark - commonMethod

- (void)shareInformationWithType:(NSInteger)shareToolType {
    switch (shareToolType) {
        case 0:{
            WXImageObject *imgObj = [WXImageObject object];
            imgObj.imageUrl =  _shareImageURL;
            
            WXWebpageObject *webObj = [WXWebpageObject object];
            webObj.webpageUrl = _shareImageURL;
            
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = _shareTitle;
            message.description = _detailInfo;
            message.mediaObject = webObj;
            
            UIImage *desImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_shareImageURL]]];
            UIImage *thumbImg = [self thumbImageWithImage:desImage limitSize:CGSizeMake(150, 150)];
            message.thumbData = UIImageJPEGRepresentation(thumbImg, 1);
            NSLog(@"%@,%lu",thumbImg,(unsigned long)message.thumbData.length);
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.scene = WXSceneSession;
            req.bText = NO;
            req.message = message;
            [WXApi sendReq:req];
            break;
        }
        case 1:{
            WXWebpageObject *webObj = [WXWebpageObject object];
            webObj.webpageUrl = _shareImageURL;
            
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = _shareTitle;
            message.description = _detailInfo;
            message.mediaObject = webObj;
            
            UIImage *desImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_shareImageURL]]];
            UIImage *thumbImg = [self thumbImageWithImage:desImage limitSize:CGSizeMake(150, 150)];
            message.thumbData = UIImageJPEGRepresentation(thumbImg, 1);
            NSLog(@"%@,%lu",thumbImg,(unsigned long)message.thumbData.length);
            
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.scene = WXSceneTimeline;
            req.bText = NO;
            req.message = message;
            [WXApi sendReq:req];
            break;
        }
        default:
            break;
    }
}

#pragma mark - WXDelegate
- (void)onResp:(BaseResp *)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        if(resp.errCode == 0)
        {
            CDVPluginResult *result = nil;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"分享成功"];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];
        }else{
            CDVPluginResult *result = nil;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"分享失败"];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];
        }
    }
}


#pragma mark - Helper

- (UIImage *)thumbImageWithImage:(UIImage *)scImg limitSize:(CGSize)limitSize
{
    if (scImg.size.width <= limitSize.width && scImg.size.height <= limitSize.height) {
        return scImg;
    }
    CGSize thumbSize;
    if (scImg.size.width / scImg.size.height > limitSize.width / limitSize.height) {
        thumbSize.width = limitSize.width;
        thumbSize.height = limitSize.width / scImg.size.width * scImg.size.height;
    }
    else {
        thumbSize.height = limitSize.height;
        thumbSize.width = limitSize.height / scImg.size.height * scImg.size.width;
    }
    UIGraphicsBeginImageContext(thumbSize);
    [scImg drawInRect:(CGRect){CGPointZero,thumbSize}];
    UIImage *thumbImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbImg;
}

@end
