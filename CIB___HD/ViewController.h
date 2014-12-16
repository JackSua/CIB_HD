//
//  ViewController.h
//  CIB___HD
//
//  Created by iOS Dev on 14-11-25.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnvConstant.h"
#import "PublicInfo.h"
#import "ActivityIndicatorView.h"
#import "NSURLRequest.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate, UIAlertViewDelegate, MAMapViewDelegate, AMapSearchDelegate>

@property (weak, nonatomic) IBOutlet UITableView *firstMenuTableView;
@property (weak, nonatomic) IBOutlet UITableView *secondMenuTableView;
@property (strong, nonatomic) IBOutlet UIWebView *mainWebView;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIView *ThirdMenuView;
@property (assign, nonatomic) BOOL isShrink;
@property (assign, nonatomic) BOOL isFirstConnectNet;
@property (strong, nonatomic) NSMutableArray *firstMenuArray;
@property (strong, nonatomic) NSMutableArray *secondMenuArray;
@property (strong, nonatomic) NSMutableArray *thirdMenuArray;
@property (strong, nonatomic) ActivityIndicatorView *activityView;
@property (strong, nonatomic) MAMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *mapBackView;
@property (strong, nonatomic) AMapSearchAPI *searchMap;
@property (strong, nonatomic) NSMutableArray *annotations;

// 缩小第一级菜单
- (void)shrinkFirstMenu;

// 放大第一级菜单
- (void)enlargeFirstMenu;

// 将 webView移动到屏幕中
- (void)webViewChangeRightToLeft;

// 将 webView 移动到右侧屏幕之外
- (void)webViewChangeLeftToRight;

@end
