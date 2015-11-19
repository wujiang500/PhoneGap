//
//  NSYNETDeviceIDPlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/14.
//
//

#import "NSYNETDeviceIDPlugin.h"
#import "VendarKeychainItemWrapper.h"

@interface NSYNETDeviceIDPlugin () 

@property (nonatomic, copy) NSString *callBackID;

@end

@implementation NSYNETDeviceIDPlugin
- (void)getDeviceId:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    if(arguments.count > 0)
    {
        self.callBackID = [arguments objectAtIndex:0];
        
        NSString *deviceNos = @"";
        
        VendarKeychainItemWrapper *wrapper = [[VendarKeychainItemWrapper alloc] initWithIdentifier:@"UUID" accessGroup:nil];
        
        @try{
            
            deviceNos=[NSString stringWithFormat:@"%@",[wrapper objectForKey:(__bridge id)(kSecValueData)]];
            
            if(![deviceNos isEqualToString:@""])
            {
                
            }
            else
            {
                deviceNos = [[[UIDevice currentDevice] identifierForVendor]UUIDString];
                [wrapper setObject:deviceNos forKey:(__bridge id)(kSecValueData)];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            NSLog(@"[wrapper objectForKey:kSecValueData]==========%@",[wrapper objectForKey:(__bridge id)(kSecValueData)]);
        }
        
        CDVPluginResult *resultDate = nil;
        resultDate = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:deviceNos];
        [self.commandDelegate sendPluginResult:resultDate callbackId:self.callBackID];
        
    }
    else
    {
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackID];
    }
    
}
@end
