//
//  CDVPlugin.h
//  CIB___HD
//
//  Created by iOS Dev on 14-12-9.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "AppDelegate.h"

@interface CDVPlugin : NSObject{
    ViewController *mainVC;
    NSString *webViewTag;
    NSString *callBackId;
}

@property(nonatomic,strong)NSString *callBackId;

//执行无参数的回调方法
-(void)executeMethodByCallBackId;

-(void)executeMethodByCallBackId:(NSString *)param;

-(void)executeMethodByCallBackIdString:(NSString *)string;

-(void)loadUrl:(NSString *)url webview:(UIWebView *)webview;

@end
