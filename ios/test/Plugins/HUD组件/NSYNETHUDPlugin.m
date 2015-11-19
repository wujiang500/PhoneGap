//
//  NSYNETHUDPlugin.m
//  test
//
//  Created by wujiang on 15/10/21.
//
//

#import "NSYNETHUDPlugin.h"
#import "MBProgressHUD.h"

@interface NSYNETHUDPlugin ()

@property (nonatomic, copy) NSString * callBackIdString;
@property (nonatomic, copy) NSString * alertMessage;

@end

@implementation NSYNETHUDPlugin

- (void)waitingHud:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    if(arguments.count > 0)
    {
        self.callBackIdString = [arguments objectAtIndex:0];
        self.alertMessage = [arguments objectAtIndex:1];
        
       // [MBProgressHUD showHUDAddedTo:self.viewController.view animated:NO];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.viewController.view animated:YES];;
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = self.alertMessage?self.alertMessage:@"";
        [hud show:YES ];
        
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"hud显示成功"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
        
    
    }else{
    
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
        
    }

}


- (void)hideAllHud:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{

    if(arguments.count > 0)
    {
        self.callBackIdString = [arguments objectAtIndex:0];
        
        [MBProgressHUD hideAllHUDsForView:self.viewController.view animated:NO];
    
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"hud隐藏成功"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
        
    }else{
    
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
        
    }

}

@end
