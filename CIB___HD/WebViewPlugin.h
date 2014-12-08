//
//  WebViewPlugin.h
//  CIB___HD
//
//  Created by iOS Dev on 14-12-8.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

#define WebViewPlugin_border_width 40
#define WebViewPlugin_border_height 80

@interface WebViewPlugin : NSObject{
    ViewController *mainVC;
    UIView *webContainer;
    UIView *_background;
    NSString *_url;
    UIButton *_closeBtn;
    UIWebView *alertWebView;
}

@property(nonatomic,strong)UIWebView *alertWebView;
@property(nonatomic,strong)UIView *webContainer;

+(WebViewPlugin *)shareInstance;

-(void)openView:(NSMutableArray *)arguments;

-(void)alertViewWithUrl:(NSString *)url;

-(void)closeView:(NSMutableArray *)arguments;

- (UIView *)alertViewWithSize:(CGSize)size url:(NSString *)url;

@end
