//
//  NSYNETMessagePlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/14.
//
//
#import "NSYNETMessagePlugin.h"
#import <MessageUI/MessageUI.h>

@interface  NSYNETMessagePlugin () <MFMessageComposeViewControllerDelegate>

@property (nonatomic, retain) NSString *currentCallBackID;

@end

@implementation NSYNETMessagePlugin

- (void)sendMessage:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    self.currentCallBackID = [arguments queueHead];
    
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
	if (messageClass)
    {
        if (![messageClass canSendText])
        {
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"设备没有短信功能"
														   delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
			[alert show];
            
            CDVPluginResult *resultDate = nil;
            NSString *resultString = @"设备没有短信功能";
            resultDate = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:resultString];
            [self.commandDelegate sendPluginResult:resultDate callbackId:self.currentCallBackID];
			return;
        }
		
    }
    else
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"iOS版本过低,不能发送短信"
													   delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
		[alert show];
        
        CDVPluginResult *resultDate = nil;
        NSString *resultString = @"iOS版本过低,不能发送短信";
        resultDate = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:resultString];
        [self.commandDelegate sendPluginResult:resultDate callbackId:self.currentCallBackID];
		return;
	}
	
    NSString* body = [options valueForKey:@"body"];
	NSString* toRecipientsString = [options valueForKey:@"toRecipients"];
	
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
	
	if(body != nil)
		picker.body = [options valueForKey:@"body"];
	
	if(toRecipientsString != nil)
		[picker setRecipients:[ toRecipientsString componentsSeparatedByString:@","]];
    
    [self.viewController presentViewController:picker animated:YES completion:^{}];
}

#pragma mark - MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    NSString *resultString = [NSString string];
	switch (result)
	{ 
		case MessageComposeResultCancelled:
            resultString = @"短信发送取消";
			break;
            
		case MessageComposeResultSent:
            resultString = @"短信发送成功";
			break;
		case MessageComposeResultFailed:
            resultString = @"短信发送失败";
			break;
		default:
            resultString = @"短信未发送";
			break;
	}
	
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                    message:resultString
//                                                   delegate:nil
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles: nil];
//    [alert show];
    
    [controller dismissViewControllerAnimated:YES completion:nil];

    CDVPluginResult *resultDate = nil;
    resultDate = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:resultString];
    [self.commandDelegate sendPluginResult:resultDate callbackId:self.currentCallBackID];
}

@end
