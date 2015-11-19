//
//  NSYNETTakePhotoPlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/09.
//
//

#import "NSYNETTakePhotoPlugin.h"

@interface NSYNETTakePhotoPlugin ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate >
@property (nonatomic, copy) NSString * callBackId;
@property (nonatomic, retain) UINavigationController    *navController;

@end

@implementation NSYNETTakePhotoPlugin
- (void)takePhoto:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    if(arguments.count > 0)
    {
        self.callBackId = [arguments objectAtIndex:0];
        //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        //    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        //        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //    }
        //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
        //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
        //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        
        self.navController = [[UINavigationController alloc] initWithRootViewController:picker];
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(scanFinished)];
        picker.navigationItem.rightBarButtonItem = item;
//        picker.navigationItem.title = title;
        [self.viewController presentViewController:picker animated:YES completion:nil];
    
    }
    else
    {
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误!"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackId];
    }

}

- (void)scanFinished
{
    [self.navController dismissViewControllerAnimated:YES completion:nil];
    CDVPluginResult *result = nil;
    NSString *returnStr = @"相机退出成功";
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:returnStr];
    [self.commandDelegate sendPluginResult:result callbackId:self.callBackId];
}

@end
