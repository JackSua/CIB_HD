//
//  WebViewPlugin.m
//  CIB___HD
//
//  Created by iOS Dev on 14-12-8.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import "WebViewPlugin.h"
#import "NSMutableArray+QueueAdditions.h"
#import "UIView+CGAffineTransform.h"
#import "AppDelegate.h"
#import "PublicInfo.h"

static WebViewPlugin *instance = nil;
@implementation WebViewPlugin

@synthesize alertWebView,webContainer;

+(WebViewPlugin *)shareInstance{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return [WebViewPlugin shareInstance];
}

-(void)openView:(NSMutableArray *)arguments{
    CGFloat x = 445;
    CGFloat y = 540;
    NSString *url = @"";
    if(arguments!=nil && arguments.count == 1){
        url = [arguments objectAtIndex:0];
    }else{
        webViewTag = [arguments pop];
        callBackId = [arguments pop];
        url = [arguments objectAtIndex:0];
        if(arguments.count > 2){
            NSString *xwidth = [arguments objectAtIndex:1];
            NSString *ywidth = [arguments objectAtIndex:2];
            if(![self stringIsEmpty:xwidth]){
                x = [xwidth floatValue];
            }
            if(![self stringIsEmpty:ywidth]){
                y = [ywidth floatValue];
            }
        }
    }
    UIView *alertVC = [self alertViewWithSize:CGSizeMake(x, y) url:url];
    [mainVC.view insertSubview:alertVC belowSubview:mainVC.activityView];
    
    if(arguments!=nil && arguments.count > 2){
        [self executeMethodByCallBackId:[arguments lastObject]]; //TODO:test
    }
}

- (UIView *)alertViewWithSize:(CGSize)size url:(NSString *)url{
    _url = url;
    webContainer = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WITH - size.width)/2-WebViewPlugin_border_width, (SCREEN_HEIGHT - size.height)/2-WebViewPlugin_border_width, size.width+WebViewPlugin_border_height, size.height+WebViewPlugin_border_height)];
    
    //WebView
    alertWebView = [[UIWebView alloc]initWithFrame:CGRectMake(40, 40, size.width, size.height)];
    alertWebView.tag = 2;
    if (IS_IOS_7 == NO) {
        alertWebView.scrollView.bounces = NO;
    }
    alertWebView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [alertWebView.layer setMasksToBounds:YES];
    [alertWebView.layer setCornerRadius:12.0];//设置矩形四个圆角半径
    alertWebView.delegate = mainVC;
    [webContainer addSubview:alertWebView];
    
    //close按钮
    _closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(onClose:) forControlEvents:UIControlEventTouchUpInside];
    _closeBtn.center = CGPointMake(alertWebView.frame.origin.x + alertWebView.frame.size.width, alertWebView.frame.origin.y);
    [webContainer addSubview:_closeBtn];
    
    //遮罩
    _background = [[UIView alloc]initWithFrame:CGRectMake(0, 0,  SCREEN_WITH, SCREEN_HEIGHT+20)];
    //半透明黑色
    _background.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    //背景点击
    //    [_background setUserInteractionEnabled:YES];
    //    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClose:)];
    //    [_background addGestureRecognizer:singleTap];
    
    
    [_background sadeIn:^{
        [_background addSubview:webContainer];
        [webContainer show:^{
            [self loadUrl:_url webview:alertWebView];
        }];
    }];
    return _background;
}

-(void)loadUrl:(NSString *)url webview:(UIWebView *)webview{
    webview.delegate = mainVC;
    //url = [NSString stringWithFormat:@"%@%@",[[InfoCtxUtil sharedInstance]getCtx],url];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:TIMER_OUT_SECOND]];
    //[webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)onClose:(id)sender
{
    callBackId = @"WebViewPlugincloseViewEvent";
    webViewTag = @"2";
    [self executeMethodByCallBackId];
    [self close];
}

-(void)close{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    [webContainer hidden:^{
        [_background sadeOut:^{
            [_background removeFromSuperview];
            //[[ActivityIndicatorView shareInstance] hiddenAnimat];
        }];
    }];
}

-(void)closeView:(NSMutableArray *)arguments
{
    if(arguments != nil){
        webViewTag = [arguments pop];
        callBackId = [arguments pop];
    }
//    [[HomeViewPlugin shareInstance]unMask:nil];

    [self executeMethodByCallBackId:[arguments lastObject]];
    [self close];
}

-(void)alertViewWithUrl:(NSString *)url
{
    [self openView:[NSMutableArray arrayWithObject:url]];
}

-(BOOL)stringIsEmpty:(NSObject *)tt{
    if(tt == [NSNull null] || tt == nil){
        return YES;
    }
    NSString *temp = (NSString *)tt;
    if(temp == nil || [@"undefined"isEqualToString:temp] || [@""isEqualToString:temp]){
        return YES;
    }
    return NO;
}

@end
