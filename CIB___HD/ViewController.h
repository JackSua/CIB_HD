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

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *firstMenuTableView;
@property (weak, nonatomic) IBOutlet UITableView *secondMenuTableView;
@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIView *ThirdMenuView;
@property (assign, nonatomic) BOOL isShrink;
@property (assign, nonatomic) BOOL isFirstConnectNet;
@property (strong, nonatomic) NSArray *firstMenuArray;
@property (strong, nonatomic) NSArray *secondMenuArray;
@property (strong, nonatomic) NSArray *thirdMenuArray;
@property (strong, nonatomic) ActivityIndicatorView *activityView;

@end
