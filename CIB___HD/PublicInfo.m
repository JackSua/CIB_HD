//
//  PublicInfo.m
//  CIB___HD
//
//  Created by iOS Dev on 14-11-26.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import "PublicInfo.h"

@implementation PublicInfo

+ (id)sharedInstance
{
    static PublicInfo *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

//返回屏幕宽度
+ (CGFloat)screenWidth
{
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0){
        return [[UIScreen mainScreen]applicationFrame].size.width;
    }
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat w = currentOrientation==UIInterfaceOrientationPortrait||currentOrientation==UIInterfaceOrientationPortraitUpsideDown?[[UIScreen mainScreen]applicationFrame].size.width:[[UIScreen mainScreen]applicationFrame].size.height;
    return w;
}

//返回屏幕高度
+ (CGFloat)screenHeight
{
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0){
        return [[UIScreen mainScreen]applicationFrame].size.height;
    }
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat h = currentOrientation==UIInterfaceOrientationPortrait||currentOrientation==UIInterfaceOrientationPortraitUpsideDown?[[UIScreen mainScreen]applicationFrame].size.height:[[UIScreen mainScreen]applicationFrame].size.width;
    return h;
}

//获取数据
+ (NSString *)getSettingValueWithName:(NSString *)name
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *value = [defaults objectForKey:name];
    
    return value;
}

@end
