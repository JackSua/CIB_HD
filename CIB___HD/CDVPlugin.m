//
//  CDVPlugin.m
//  CIB___HD
//
//  Created by iOS Dev on 14-12-9.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import "CDVPlugin.h"
#import "WebViewPlugin.h"

@implementation CDVPlugin

@synthesize callBackId;

- (id)init{
    self = [super init];
    if(self){
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        mainVC =  (ViewController *)appDelegate.window.rootViewController;
        
    }
    return self;
}

-(void)executeMethodByCallBackId
{
    if(callBackId != nil && ![@""isEqualToString:callBackId] && webViewTag != nil && ![@""isEqualToString:webViewTag]){
        if([@"1"isEqualToString:webViewTag]){
            [mainVC.mainWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@()",callBackId]];
        }else if([@"2"isEqualToString:webViewTag]){
            [[WebViewPlugin shareInstance].alertWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@()",callBackId]];
        }
    }
}

-(void)executeMethodByCallBackId:(NSString *)param
{
    if(callBackId != nil && ![@""isEqualToString:callBackId] && webViewTag != nil && ![@""isEqualToString:webViewTag]){
        if([@"1"isEqualToString:webViewTag]){
            [mainVC.mainWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@')",callBackId,param]];
        }else if([@"2"isEqualToString:webViewTag]){
            [[WebViewPlugin shareInstance].alertWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@')",callBackId,param]];
        }
    }
}

-(void)executeMethodByCallBackIdString:(NSString *)string
{
    if(callBackId != nil && ![@""isEqualToString:callBackId] && webViewTag != nil && ![@""isEqualToString:webViewTag]){
        if([@"1"isEqualToString:webViewTag]){
            [mainVC.mainWebView stringByEvaluatingJavaScriptFromString:string];
        }else if([@"2"isEqualToString:webViewTag]){
            [[WebViewPlugin shareInstance].alertWebView stringByEvaluatingJavaScriptFromString:string];
        }
    }
}

-(void)loadUrl:(NSString *)url webview:(UIWebView *)webview
{
    webview.delegate = mainVC;
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:TIMER_OUT_SECOND]];
}

@end
