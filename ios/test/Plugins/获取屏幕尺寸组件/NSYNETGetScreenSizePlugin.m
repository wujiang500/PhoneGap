//
//  NSYNETGetScreenSizePlugin.m
//  test
//
//  Created by wujiang on 15/10/21.
//
//

#import "NSYNETGetScreenSizePlugin.h"

@interface NSYNETGetScreenSizePlugin ()

@property (nonatomic, copy) NSString * callBackIdString;

@end

@implementation NSYNETGetScreenSizePlugin

- (void)getScreenSize:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    if(arguments.count > 0)
    {
        self.callBackIdString = [arguments objectAtIndex:0];
        
        CGRect rect = [ UIScreen mainScreen ].bounds;
        CGFloat width = rect.size.width;
        CGFloat height = rect.size.height;
        NSString * sizeStirng = [NSString stringWithFormat:@"%f/%f",width,height];
        
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:sizeStirng];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];

        
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
    }

}

@end
