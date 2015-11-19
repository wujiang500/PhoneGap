//
//  NSYNETScanOfficeFilePlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/11.
//
//

#import "NSYNETScanOfficeFilePlugin.h"

@interface NSYNETScanOfficeFilePlugin () 
/// 回调用的ID
@property (nonatomic, retain) NSString      *callBackID;

/// 浏览控制器
@property (nonatomic, retain) UINavigationController    *navController;

@end

@implementation NSYNETScanOfficeFilePlugin

- (void)scanOfficeFile:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    if(arguments.count > 1)
    {
        self.callBackID = [arguments objectAtIndex:0];
        NSString *filePath = [NSString stringWithFormat:@"%@/test.app/%@",NSHomeDirectory(),[arguments objectAtIndex:1]];
        NSString *title = [filePath lastPathComponent];
        
        
        UIViewController *controller = [[UIViewController alloc] init];
        UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.viewController.view.bounds.size.width,self.viewController.view.bounds.size.height)];
        webView.scalesPageToFit = YES;
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
        [controller.view addSubview:webView];
        
    
        self.navController = [[UINavigationController alloc] initWithRootViewController:controller];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(scanFinished)];
        controller.navigationItem.rightBarButtonItem = item;
        controller.navigationItem.title = title;
        
        [self.viewController presentViewController:self.navController animated:YES completion:nil];
    }
    else
    {
        CDVPluginResult * result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackID];
    }
}

- (void)scanFinished
{
    [self.navController dismissViewControllerAnimated:YES completion:nil];
    
    CDVPluginResult *result = nil;
    NSString *returnStr = @"0";
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:returnStr];
    [self.commandDelegate sendPluginResult:result callbackId:self.callBackID];
}

@end
