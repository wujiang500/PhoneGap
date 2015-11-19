//
//  NSYNETUnionPayPlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/20.
//
//

#import "NSYNETUnionPayPlugin.h"
#import "UPPayPlugin.h"
#import "UPPayPluginDelegate.h"

@interface NSYNETUnionPayPlugin () <UPPayPluginDelegate>

@property (nonatomic,copy) NSString * callBackIdString;

@property (nonatomic, retain) NSDictionary * parametersDict;
@property (nonatomic, copy) NSString * urlString;
@property (nonatomic, copy) NSString * contentType;

@end


@implementation NSYNETUnionPayPlugin

- (void)UnionPay:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    
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
        

        [manager POST:self.urlString parameters:self.parametersDict success:^(AFHTTPRequestOperation *operation, NSDictionary *  responseObject) {
            NSLog(@"JSON:%@", responseObject);
            NSString * sn = [responseObject objectForKey:@"sn"];
            
            [UPPayPlugin startPay:sn mode:@"00" viewController:self.viewController delegate:self];
                      
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

-(void)UPPayPluginResult:(NSString *)result
{
    if([result isEqualToString:@"success"])
    {
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"支付成功"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];
        
    }else{
        
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"支付失败"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];
    
    }
}




@end
