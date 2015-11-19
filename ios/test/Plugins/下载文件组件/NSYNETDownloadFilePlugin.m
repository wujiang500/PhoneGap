//
//  NSYNETDownloadFilePlugin.m
//  Hello World
//
//  Created by wujiang on 15/9/30.
//
//

#import "NSYNETDownloadFilePlugin.h"

@interface NSYNETDownloadFilePlugin () 

@property (nonatomic, copy) NSString * callBackIDString;
@property (nonatomic, copy) NSString * urlString;
@property (nonatomic, retain) NSDictionary * paramDic;
@property (nonatomic, copy) NSString * savedPath;
@end


@implementation NSYNETDownloadFilePlugin

- (void)downloadFile:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    self.callBackIDString = [arguments objectAtIndex:0];
    if(arguments.count > 0)
    {
        self.urlString = [arguments objectAtIndex:1];
        self.paramDic = [arguments objectAtIndex:2];
        NSString * saveName = [arguments objectAtIndex:3];
        NSString * sageFullName = [NSString stringWithFormat:@"%@/Documents/.zip",saveName];
        
        
        //沙盒路径
        self.savedPath = [NSHomeDirectory() stringByAppendingString:sageFullName];
        
        AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
        NSMutableURLRequest *request =[serializer requestWithMethod:@"POST" URLString:self.urlString parameters:self.paramDic error:nil];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
        [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:self.savedPath append:NO]];
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            //            float p = (float)totalBytesRead / totalBytesExpectedToRead;
            //            progress(p);
            //            NSLog(@"download：%f", (float)totalBytesRead / totalBytesExpectedToRead);
            //
        }];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"下载成功");
            
            CDVPluginResult *result = nil;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:self.savedPath];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"下载失败");
            
            CDVPluginResult *result = nil;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error description]];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
            
        }];
        
        [operation start];
    }
    else
    {
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
    }
    

}


@end
