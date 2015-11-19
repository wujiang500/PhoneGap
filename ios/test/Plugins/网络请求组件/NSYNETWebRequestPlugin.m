//
//  NSYNETWebRequestPlugin.m
//  Hello World
//
//  Created by wujiang on 15/9/30.
//
//

#import "NSYNETWebRequestPlugin.h"
@interface NSYNETWebRequestPlugin () 

@property (nonatomic, copy) NSString * currentCallBackID;
@property (nonatomic, retain) NSDictionary * resultDict;
@property (nonatomic, retain) NSDictionary * parametersDict;
@property (nonatomic, copy) NSString * urlString;
@property (nonatomic, copy) NSString * contentType;
@end
@implementation NSYNETWebRequestPlugin
- (void)httpRequest:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    
    self.currentCallBackID = [arguments objectAtIndex:0];

    if(arguments.count > 0)
    {
        self.parametersDict =  [arguments objectAtIndex:1];
        self.urlString =       [arguments objectAtIndex:2];
        self.contentType =     [arguments objectAtIndex:3];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:self.contentType]; //@"text/html"
        
        //发送请求
        [manager POST:self.urlString parameters:self.parametersDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON:%@", responseObject);
            
            CDVPluginResult *result = nil;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:responseObject];
            [self.commandDelegate sendPluginResult:result callbackId:self.currentCallBackID];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            CDVPluginResult *result = nil;            
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error description]];
            [self.commandDelegate sendPluginResult:result callbackId:self.currentCallBackID];
        }];
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"网络请求参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId:self.currentCallBackID];
        
    }
}





@end
