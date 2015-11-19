//
//  NSYNETPickerDatePlugin.m
//  test
//
//  Created by wujiang on 15/10/30.
//
//

#import "NSYNETPickerDatePlugin.h"

@interface NSYNETPickerDatePlugin ()

@property (nonatomic, copy) NSString * callBackIdString;

@property (nonatomic, copy) NSString * xString;
@property (nonatomic, copy) NSString * yString;
@property (nonatomic, copy) NSString * widthString;
@property (nonatomic, copy) NSString * heightString;

@property (nonatomic, copy) NSString * minDateString;
@property (nonatomic, copy) NSString * maxDateString;

@end

@implementation NSYNETPickerDatePlugin

- (void)pickerDate:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    if(arguments.count > 6)
    {
        
        self.callBackIdString = [arguments objectAtIndex:0];

        self.xString = [arguments objectAtIndex:1];
        self.yString = [arguments objectAtIndex:2];
        self.widthString = [arguments objectAtIndex:3];
        self.heightString = [arguments objectAtIndex:4];
        
        self.minDateString = [arguments objectAtIndex:5];
        self.maxDateString = [arguments objectAtIndex:6];

        [self createDatePicker];
        
    }else{
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
    }
}
- (void)createDatePicker
{
    UIDatePicker * datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake([self.xString integerValue],[self.yString integerValue], [self.widthString integerValue], [self.heightString integerValue])];
    
    datePicker.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    NSString * minDateStr = [NSString stringWithFormat:@"%@",self.minDateString];
    NSString * maxDateStr = [NSString stringWithFormat:@"%@",self.maxDateString];
    
    NSDate * minDate = [self stringToDate:minDateStr];
    NSDate * maxDate = [self stringToDate:maxDateStr];
    
    datePicker.minimumDate = minDate;
    datePicker.maximumDate = maxDate;
    
    [datePicker setDate:[NSDate date] animated:YES];
    
    [datePicker addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
    
    [self.viewController.view addSubview:datePicker];

}
- (void)selectDate:(UIDatePicker *)picker
{
    NSDate * selectDate = picker.date;
    NSString * resultStr = [NSString stringWithFormat:@"%@",selectDate];
    
    CDVPluginResult *result = nil;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:resultStr];
    [self.commandDelegate sendPluginResult:result callbackId: self.callBackIdString];
}

- (NSDate *)stringToDate:(NSString *)dateString
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
    [inputFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate* inputDate = [inputFormatter dateFromString:dateString];
    
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: inputDate];
    inputDate = [inputDate  dateByAddingTimeInterval: frominterval];
    
    return inputDate;
}
@end
