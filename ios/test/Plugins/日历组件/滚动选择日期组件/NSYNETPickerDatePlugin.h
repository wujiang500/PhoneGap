//
//  NSYNETPickerDatePlugin.h
//  test
//
//  Created by wujiang on 15/10/30.
//
//

#import <Cordova/CDV.h>

@interface NSYNETPickerDatePlugin : CDVPlugin

/**
 *  Picker日历
 *
 *  @param arguments 参数数组
 *  @param options   参数字典
 */
- (void)pickerDate:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


@end
