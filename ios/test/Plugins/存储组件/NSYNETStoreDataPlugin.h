//
//  NSYNETStoreDataPlugin.h
//  test
//
//  Created by wujiang on 15/10/21.
//
//

#import <Cordova/CDV.h>

@interface NSYNETStoreDataPlugin : CDVPlugin

/**
 *  存储
 *
 *  @param arguments 参数数组
 *  @param options   参数字典
 */
- (void)storageData:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;



/**
 *  提取
 *
 *  @param arguments 参数数组
 *  @param options   参数字典
 */
- (void)getData:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;


/**
 *  删除
 *
 *  @param arguments 参数数组
 *  @param options   参数字典
 */
- (void)deleteData:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options;



@end
