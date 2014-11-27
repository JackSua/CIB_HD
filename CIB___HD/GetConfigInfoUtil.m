//
//  GetConfigInfoUtil.m
//  CIB___HD
//
//  Created by iOS Dev on 14-11-26.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import "GetConfigInfoUtil.h"

@implementation GetConfigInfoUtil

+ (id)sharedInstance
{
    static GetConfigInfoUtil *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end
