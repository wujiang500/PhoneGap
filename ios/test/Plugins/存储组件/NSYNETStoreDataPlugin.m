//
//  NSYNETStoreDataPlugin.m
//  test
//
//  Created by wujiang on 15/10/21.
//
//

#import "NSYNETStoreDataPlugin.h"
#import "TMDiskCache.h"


@interface NSYNETStoreDataPlugin ()

@property (nonatomic, copy) NSString * callBackIdString;
@property (nonatomic, retain) NSDictionary * valueDict;
@property (nonatomic, copy) NSString * keyValueString;


@end

@implementation NSYNETStoreDataPlugin

- (void)storageData:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    if(arguments.count > 2)
    {
        self.callBackIdString = [arguments objectAtIndex:0];
        self.valueDict = [arguments objectAtIndex:1];
        self.keyValueString = [arguments objectAtIndex:2];
        
        [[TMDiskCache sharedCache]setObject:self.valueDict forKey:self.keyValueString];
        
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
        
    
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
    }
    
}


- (void)getData:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    
    if(arguments.count > 1)
    {
        self.callBackIdString = [arguments objectAtIndex:0];
        self.keyValueString = [arguments objectAtIndex:1];
        
        NSString * string = (NSString *)[[TMDiskCache sharedCache] objectForKey:self.keyValueString];
        
        
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:string];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
        

        
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
    }


}


- (void)deleteData:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    if(arguments.count > 1)
    {
        self.callBackIdString = [arguments objectAtIndex:0];
        self.keyValueString = [arguments objectAtIndex:1];
        
        [[TMDiskCache sharedCache] removeObjectForKey:self.keyValueString];
        
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"删除成功"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
        
        
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
    }
    


}

@end
