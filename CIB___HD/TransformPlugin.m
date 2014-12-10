//
//  TransformPlugin.m
//  CIB___HD
//
//  Created by iOS Dev on 14-12-10.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import "TransformPlugin.h"
#import "NSMutableArray+QueueAdditions.h"

static TransformPlugin *instance = nil;

@implementation TransformPlugin

+(TransformPlugin *)shareInstance{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return [TransformPlugin shareInstance];
}

- (void)translationWebFromLeftToRight:(NSMutableArray *)arguments
{
    [mainVC webViewChangeLeftToRight];
    [self callBackAction:arguments];
}

- (void)translationWebFromRightToLeft:(NSMutableArray *)arguments
{
    [mainVC webViewChangeRightToLeft];
    [self callBackAction:arguments];
}

- (void)callBackAction:(NSMutableArray *)arguments
{
    if(arguments!=nil && arguments.count == 2){
        webViewTag = [arguments pop];
        callBackId = [arguments pop];
    }
    [self executeMethodByCallBackId];
}

@end
