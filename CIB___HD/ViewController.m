//
//  ViewController.m
//  CIB___HD
//
//  Created by iOS Dev on 14-11-25.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.isFirstConnectNet = YES;
    
    // FIXME:测试数据
    self.firstMenuArray = [NSArray arrayWithObjects:@"移动金融",@"投资理财",@"信用卡",@"金融助手", nil];
    self.secondMenuArray = [NSArray arrayWithObjects:@"账户查询",@"服务管理",@"资金归集",@"贷款融资",@"兴业e卡",@"自助缴费",@"转账汇款", nil];
    self.thirdMenuArray = [NSArray arrayWithObjects:@"紧急挂失",@"行内账户管理",@"功能与限额设置",@"安全保护",@"密码修改",@"个人资料修改",@"登陆方式管理",@"注销网上银行", nil];
    
    [self createView];
    
    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:CIB_IP]]];
    
}



- (void)createView
{
    self.activityView = [[ActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WITH, SCREEN_HEIGHT)];
    [self.view addSubview:self.activityView];
    
    [self.firstMenuTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.secondMenuTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    //[self.mainWebView setFrame:CGRectMake([PublicInfo screenWidth], 69, [PublicInfo screenWidth]-191, 69)];
    
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 5; j++) {
            if ((i*5+j) >= self.thirdMenuArray.count) {
                break;
            }
            UIButton *btnThirdMenu = [UIButton buttonWithType:UIButtonTypeSystem];
            btnThirdMenu.frame = CGRectMake(self.ThirdMenuView.frame.size.width/5*j, self.ThirdMenuView.frame.size.height/4*i, self.ThirdMenuView.frame.size.width/5, self.ThirdMenuView.frame.size.height/4);
            [btnThirdMenu setTitle:self.thirdMenuArray[i*5+j] forState:UIControlStateNormal];
            btnThirdMenu.layer.borderColor = [[UIColor blackColor] CGColor];
            btnThirdMenu.layer.borderWidth = 0.5;
            [btnThirdMenu addTarget:self action:@selector(doBtnThirdMenu:) forControlEvents:UIControlEventTouchUpInside];
            [self.ThirdMenuView addSubview:btnThirdMenu];
        }
    }
    
    //btnThirdMenu.frame.size = CGSizeMake(self.ThirdMenuView.frame.size.width/5, self.ThirdMenuView.frame.size.height/4);
}

- (void)doBtnThirdMenu:(UIButton *)sender
{
    [self webViewChangeRightToLeft];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // TODO:固定值
    if (tableView == self.firstMenuTableView) {
        return self.firstMenuArray.count;
    }else if (tableView == self.secondMenuTableView){
        return self.secondMenuArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =nil;
    if (tableView == self.firstMenuTableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"firstMenuCell"];
        UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
        backView.backgroundColor = [UIColor colorWithRed:233/255.0 green:254/255.0 blue:250/255.0 alpha:1.0];
        cell.selectedBackgroundView = backView;
        cell.textLabel.text = self.firstMenuArray[indexPath.row];  // FIXME:测试数据
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
    }else if (tableView == self.secondMenuTableView){
        cell = [tableView dequeueReusableCellWithIdentifier:@"secondMenuCell"];
        cell.textLabel.text = self.secondMenuArray[indexPath.row]; // FIXME:测试数据
        cell.textLabel.textAlignment = NSTextAlignmentRight;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (tableView == self.firstMenuTableView) {
        if (!self.isShrink) {
            [self shrinkFirstMenu];
        }else{
            [self enlargeFirstMenu];
        }
        
        if (indexPath.row == 0) {
            
        }
        
    }else if (tableView == self.secondMenuTableView){
        [self webViewChangeLeftToRight];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.firstMenuTableView) {
        if (self.isShrink == YES) {
            return 55;
        }else{
            return 164;
        }
        
    }else if (tableView == self.secondMenuTableView){
        return 44;
    }
    return 0;
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [self.activityView startAnimat];
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (self.isFirstConnectNet) {
        self.isFirstConnectNet = NO;
    }
    
    [self.activityView stopAnimat];
    NSLog(@"载入网页成功!");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityView stopAnimat];
    NSLog(@"载入页面失败!");
}

#pragma mark - 页面动画

// 缩小第一级菜单
- (void)shrinkFirstMenu
{
    [UIView animateWithDuration:0.8 animations:^{
        self.isShrink = YES;
        [self.firstMenuTableView setFrame:CGRectMake(0, 69, 55, 654)];
        [self.firstMenuTableView setRowHeight:55];
        [self.firstMenuTableView reloadData];
    }];
}

// 放大第一级菜单
- (void)enlargeFirstMenu
{
    [UIView animateWithDuration:0.8 animations:^{
        self.isShrink = NO;
        [self.firstMenuTableView setFrame:CGRectMake(0, 69, 191, 654)];
        [self.firstMenuTableView setRowHeight:164];
        [self.firstMenuTableView reloadData];
    }];
}

// 将 webView移动到屏幕中
- (void)webViewChangeRightToLeft
{
    [UIView animateWithDuration:0.5 animations:^{
        [self.mainWebView setFrame:CGRectMake(191, 69, MAIN_WEBVIEW_WIDTH, MAIN_WEBVIEW_HEIGHT)];
    }];
}

// 将 webView 移动到右侧屏幕之外
- (void)webViewChangeLeftToRight
{
    [UIView animateWithDuration:0.5 animations:^{
        [self.mainWebView setFrame:CGRectMake([PublicInfo screenWidth], 69, MAIN_WEBVIEW_WIDTH, MAIN_WEBVIEW_HEIGHT)];
    }];
}

@end
