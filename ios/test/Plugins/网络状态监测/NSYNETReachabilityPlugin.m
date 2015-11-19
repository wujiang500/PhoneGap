//
//  NSYNETReachabilityPlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/13.
//
//

#import "NSYNETReachabilityPlugin.h"

@interface NSYNETReachabilityPlugin ()

@property (nonatomic, copy) NSString *callBackIDString;
@end


static NSString * const AFAppDotNetAPIBaseURLString = @"https://api.app.net/";


@implementation NSYNETReachabilityPlugin

- (void)isNetConnect:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    
    self.callBackIDString = [arguments objectAtIndex:0];
    if(arguments.count > 0)
    {
        __block  NSString * connectMessage = @"";
        AFHTTPSessionManager * manager =  [[AFHTTPSessionManager manager]initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]] ;
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:
                    connectMessage = @"00";
                    
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    connectMessage = @"01";
                    
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    connectMessage = @"02";
                    
                    break;
                case AFNetworkReachabilityStatusUnknown:
                    connectMessage = @"03";
                    
                    break;
                    
                default:
                    break;
            }
            
            CDVPluginResult *result = nil;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:connectMessage];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
        }];
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
        
    }

}
@end
