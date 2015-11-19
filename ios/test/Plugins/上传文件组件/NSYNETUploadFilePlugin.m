//
//  NSYNETUploadFilePlugin.m
//  Hello World
//
//  Created by wujiang on 15/9/30.
//
//

#import "NSYNETUploadFilePlugin.h"
@interface NSYNETUploadFilePlugin () 

@property (nonatomic, copy)   NSString * callBackIDString;
@property (nonatomic, copy)   NSString * fileName;
@property (nonatomic, retain) NSDictionary * paramDic;
@property (nonatomic, copy)   NSString * filePath;
@property (nonatomic, copy)   NSString * typeString;
@end

@implementation NSYNETUploadFilePlugin

- (void)uploadFile:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    
    self.callBackIDString = [arguments objectAtIndex:0];
    self.fileName = [arguments objectAtIndex:1];
    self.filePath = [arguments objectAtIndex:2];
    self.typeString = [arguments objectAtIndex:3];
    if(arguments.count > 0)
    {
        self.paramDic = @{@"":@""};
        
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        [manager POST:@"" parameters:self.paramDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

            [formData appendPartWithFileURL:[NSURL URLWithString:self.filePath] name:self.fileName fileName:[NSString stringWithFormat:@"%@",self.fileName] mimeType:self.typeString error:nil];
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"上传成功");
            
            CDVPluginResult *result = nil;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:responseObject];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"服务器相应出错");
            CDVPluginResult *result = nil;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error description]];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
        }];
    }
    else
    {
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
    }

}

@end
