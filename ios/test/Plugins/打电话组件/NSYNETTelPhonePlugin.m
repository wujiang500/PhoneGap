//
//  NSYNETTelPhonePlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/14.
//
//

#import "NSYNETTelPhonePlugin.h"

@interface NSYNETTelPhonePlugin ()

@property (nonatomic, copy) NSString * currentCallBackID;
@property (nonatomic, copy) NSString * phoneNumString;

@end

@implementation NSYNETTelPhonePlugin
- (void)callPhone:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    
    if(arguments.count > 1)
    {
        self.currentCallBackID = [arguments queueHead];
        self.phoneNumString = [arguments objectAtIndex:1];
        
        NSString *deviceType = [UIDevice currentDevice].model;
        
        if([deviceType isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"] || [deviceType  isEqualToString:@"iPad Simulator"])
        {
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil
//                                                          message:@"当前设备不能打电话"
//                                                         delegate:nil
//                                                cancelButtonTitle:@"OK"
//                                                otherButtonTitles:nil,nil];
//            [alert show];
            
            CDVPluginResult *resultDate = nil;
            NSString *resultString = @"当前设备不能打电话";
            resultDate = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:resultString];
            [self.commandDelegate sendPluginResult:resultDate callbackId:self.currentCallBackID];
            return;
        }
        else
        {
            NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",self.phoneNumString];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
        }
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId:self.currentCallBackID];
    }
}
@end
