//
//  PublicInfo.h
//  CIB___HD
//
//  Created by iOS Dev on 14-11-26.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicInfo : NSObject

#define MAIN_WEBVIEW_WIDTH 833
#define MAIN_WEBVIEW_HEIGHT 654
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
#define SCREEN_WITH [PublicInfo screenWidth]
#define SCREEN_HEIGHT [PublicInfo screenHeight]
#define TIMER_OUT_SECOND 20.0

+ (id)sharedInstance;

//返回屏幕宽度
+ (CGFloat)screenWidth;

//返回屏幕高度
+ (CGFloat)screenHeight;

//获取Settings数据
+(NSString *)getSettingValueWithName:(NSString *)name;

@end
