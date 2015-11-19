//
//  NSYNETGesturePasswordPlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/15.
//
//

#import "NSYNETGesturePasswordPlugin.h"
#import "GesturePasswordController.h"

@interface NSYNETGesturePasswordPlugin () 

@property (nonatomic, copy) NSString * callBackIDString;
@property (nonatomic, retain) UINavigationController    *navController;

@end

@implementation NSYNETGesturePasswordPlugin

- (void)gesturePassword:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    if(arguments >0)
    {
        self.callBackIDString = [arguments objectAtIndex:0];
        GesturePasswordController * gpvc = [[GesturePasswordController alloc] init];
        self.navController = [[UINavigationController alloc] initWithRootViewController:gpvc];

        [self.viewController presentViewController:self.navController animated:YES completion:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealWithAction) name:SET_GESTUREPASSWORD_SUCCESS object:nil];
        
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误!"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
    }
}

- (void)dealWithAction
{
    NSLog(@"手势密码验证成功");
    
    CDVPluginResult *result = nil;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"设置验证成功"];
    [self.commandDelegate sendPluginResult:result callbackId:self.callBackIDString];
}

@end
