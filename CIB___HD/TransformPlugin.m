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

- (void)changeLoginBtnTitle:(NSMutableArray *)arguments
{
    if (arguments!=nil && arguments.count !=0) {
        webViewTag = [arguments pop];
        callBackId = [arguments pop];
        NSString *str = [arguments pop];
        if (str&& ![str isEqualToString:@""] && str.length != 0) {
            if ([str isEqualToString:@"logined"]) {
                [mainVC.btnLogin setTitle:@"注销" forState:UIControlStateNormal];
            }else if ([str isEqualToString:@"loginOut"]){
                [mainVC.btnLogin setTitle:@"登录" forState:UIControlStateNormal];
            }
        }
        NSInteger tagN = [[arguments pop] intValue];

        mainVC.btnLogin.tag = tagN;
    }
    [self executeMethodByCallBackId];
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

- (void)showMap:(NSMutableArray *)arguments
{
    [mainVC showMap];
    [self callBackAction:arguments];
}

- (void)dismissMap:(NSMutableArray *)arguments
{
    [mainVC dismissMap];
    [self callBackAction:arguments];
}

@end
