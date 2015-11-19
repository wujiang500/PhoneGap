//
//  NSYNETPhotoLibraryPlugin.m
//  test
//
//  Created by wujiang on 15/10/21.
//
//

#import "NSYNETPhotoLibraryPlugin.h"
#import "JSONKit.h"
@interface NSYNETPhotoLibraryPlugin () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,copy)      NSString * callBackIdString;
@property (nonatomic,retain)    UIPopoverController *popover;

@end

@implementation NSYNETPhotoLibraryPlugin
- (void)photoLibrary:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    
    if(arguments.count == 0)
    {
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
        return;
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController* imagepicker = [[UIImagePickerController alloc] init];
        imagepicker.delegate = self;
        imagepicker.mediaTypes=[NSArray arrayWithObjects:(NSString *)kUTTypeMovie,(NSString*)kUTTypeImage, nil];
        imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagepicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagepicker.allowsEditing = NO;
        if ([[[UIDevice currentDevice]model]hasPrefix:@"iPad"])
        {
            self.popover = [[UIPopoverController alloc] initWithContentViewController:imagepicker];
            [self.popover presentPopoverFromRect:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) inView:self.viewController.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        else
        {
            [self.viewController presentViewController:imagepicker animated:YES completion:^{
                
            }];
        }
    }
    else
    {
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"设备不支持图库"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
        
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType= [NSString stringWithFormat:@"%@",[info valueForKey:UIImagePickerControllerMediaType]];
    NSString *mediaURL= [NSString stringWithFormat:@"%@",[info valueForKey:UIImagePickerControllerReferenceURL]];
    
    UIImage *image = nil;
    NSString *imageDataPath = @"";
    NSString *videoURL = nil;
    if ([mediaType isEqualToString:@"public.image"]) {
        image = [info valueForKey:UIImagePickerControllerOriginalImage];
        
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
        imageDataPath = [NSString stringWithFormat:@"%@/Documents/CameraImage/%lf.PNG",NSHomeDirectory(),[[NSDate date] timeIntervalSince1970]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:imageDataPath]) {
            NSError *error;
            [[NSFileManager defaultManager] removeItemAtPath:imageDataPath error:&error];
        }
        
        [imageData writeToFile:imageDataPath atomically:YES];
    } else if ([mediaType isEqualToString:@"public.movie"]) {
        videoURL = [info valueForKey:UIImagePickerControllerMediaURL];
        
//        UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        if ([mediaType isEqualToString:@"public.image"])
        {
            
            NSString *directoryPath=[documentsDirectory stringByAppendingPathComponent:@"CameraImage"];
            if (![[NSFileManager defaultManager]fileExistsAtPath:directoryPath])
            {
                BOOL  isCreate = [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
                if (!isCreate)
                {
                    NSLog(@"媒体库路径创建失败");
                }
            }
        }
//        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
        NSString *imageDataPath = [NSString stringWithFormat:@"%@/Documents/CameraImage/%ld.PNG",NSHomeDirectory(),(long)[[NSDate date] timeIntervalSince1970]];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:imageDataPath]) {
            NSError *error;
            [[NSFileManager defaultManager] removeItemAtPath:imageDataPath error:&error];
        }
    }
    
    //    NSString *videoDataPath = [NSString stringWithFormat:@"%@/Documents/CameraImage/%lf.PNG",NSHomeDirectory(),[[NSDate date] timeIntervalSince1970]];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:mediaType,@"mediaType",mediaURL,@"mediaURL",imageDataPath,@"imageDataPath", nil];
    
    if (image)
    {
        [dict setObject:image forKey:@"mediaImage"];
    }
    
    if (videoURL)
    {
        [dict setObject:videoURL forKey:@"movURL"];
    }
    
    CDVPluginResult *result = nil;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[dict JSONString]];
    [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];

    
}

@end
