//
//  NSYNETCalenderPlugin.m
//  test
//
//  Created by wujiang on 15/10/23.
//
//

#import "NSYNETCalenderPlugin.h"
#import "NSYNETCalenderVC.h"
#import "CKCalendarView.h"
#import "UIColor+LTColor.h"

@interface NSYNETCalenderPlugin () <CKCalendarDelegate>

@property (nonatomic, copy) NSString * callBackIdString;
@property (nonatomic, retain) UINavigationController    *navController;

@end

@implementation NSYNETCalenderPlugin

- (void)calender:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    if(arguments.count > 0)
    {
        self.callBackIdString = [arguments objectAtIndex:0];
        
        NSYNETCalenderVC * pvc = [[NSYNETCalenderVC alloc] init];
        
        CKCalendarView *calendar = [[CKCalendarView alloc] init];
        
        
        calendar.monthShowing = [NSDate date];
        calendar.judgeSelectStartDate = [NSDate date];
//        calendar.monthEnd = endDate;
        calendar.titleColor = [UIColor blackColor];
        calendar.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        calendar.delegate = self;
        pvc.view.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        
        pvc.title = @"选择日期";
        [pvc.view addSubview:calendar];
        
        
        self.navController = [[UINavigationController alloc] initWithRootViewController:pvc];
        
        if([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
        {
            self.navController.navigationBar.barTintColor = [UIColor colorWithRed:213/255.0 green:34/255.0 blue:28/255.0 alpha:1];
        }
        
        self.navController.navigationBar.translucent = NO;
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(scanFinished)];
        item.tintColor = [UIColor whiteColor];
        pvc.navigationItem.leftBarButtonItem = item;
        [self.viewController presentViewController:self.navController animated:YES completion:nil];
        
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
    }
}

- (void)scanFinished
{
    [self.navController dismissViewControllerAnimated:YES completion:nil];
    CDVPluginResult *result = nil;
    NSString *returnStr = @"日历退出成功";
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:returnStr];
    [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
}
#pragma mark - CKCalendarDelegate
- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date
{
    return YES;
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date
{
    CDVPluginResult *result = nil;
    NSString *returnStr = [NSString stringWithFormat:@"%@",date];
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:returnStr];
    [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
}

//- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date
//{
//
//}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date
{
    return YES;
}


@end
