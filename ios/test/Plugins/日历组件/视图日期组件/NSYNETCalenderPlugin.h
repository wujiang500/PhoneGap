//
//  NSYNETCalenderPlugin.h
//  test
//
//  Created by wujiang on 15/10/21.
//
//

#import <Cordova/CDV.h>

@interface NSYNETCalenderPlugin : CDVPlugin

/**
 *  日历
 *
 *  @param arguments 参数数组
 *  @param options   参数字典
 */
- (void)calender:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


@end
