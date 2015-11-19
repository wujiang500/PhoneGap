//
//  NSYNETKillAPPPlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/08.
//
//


#import "NSYNETKillAPPPlugin.h"

@implementation NSYNETKillAPPPlugin

- (void)killApp:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    exit(0);
}

@end
