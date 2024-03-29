//
//  ViewController.m
//  CIB___HD
//
//  Created by iOS Dev on 14-11-25.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "UIUrlButton.h"
#import "BasicPlugin.h"
#import "WebViewPlugin.h"
#import "MYIntroductionView.h"
#import "POIAnnotation.h"

#define kFilename @"menuList.txt"

@interface ViewController ()<MYIntroductionDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.isFirstConnectNet = YES;
    
    [self.firstMenuTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.secondMenuTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
/*
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"MenuList" withExtension:@"plist"]];

    if ([NSJSONSerialization isValidJSONObject:dic]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        [data writeToFile:[self dataFilePath] atomically:YES]; //将json地址写入文件
    }
    
    self.firstMenuArray = [dic objectForKey:@"menuList"];
    if (self.secondMenuArray.count == 0) {
        self.secondMenuArray = [[self.firstMenuArray objectAtIndex:0] valueForKey:@"child"];
    }
    if (self.thirdMenuArray.count == 0) {
        self.thirdMenuArray = [[self.secondMenuArray objectAtIndex:0] valueForKey:@"child"];
    }
*/
    self.activityView = [[ActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WITH, SCREEN_HEIGHT)];
    [self.view addSubview:self.activityView];
    // 载入首页
    [self loadHomePage];
    
    [self configMapView];
}

- (void)showMap
{
    [UIView animateWithDuration:0.3 animations:^{
        self.mapBackView.center = CGPointMake(self.bottomBarView.frame.size.width/2+191, 69+MAIN_WEBVIEW_HEIGHT/2);
        self.mapView.showsUserLocation = YES;
    }];
}

- (void)dismissMap
{
    [UIView animateWithDuration:0.3 animations:^{
        self.mapBackView.center = CGPointMake(self.bottomBarView.frame.size.width/2+191, self.bottomBarView.frame.origin.y+MAIN_WEBVIEW_HEIGHT/2+60);
        self.mapView.showsUserLocation = NO;
    }];
}

- (void)configMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.mapBackView.frame.size.width, self.mapBackView.frame.size.height)];
    self.mapView.delegate = self;
    self.mapView.mapType = MAMapTypeStandard;
    self.mapView.showsUserLocation = NO;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.mapView setZoomLevel:15 animated:YES];
    [self.mapBackView addSubview:self.mapView];
    
    self.mapBackView.center = CGPointMake(self.bottomBarView.frame.size.width/2+191, self.bottomBarView.frame.origin.y+MAIN_WEBVIEW_HEIGHT/2+60);
    
    self.searchMap = [[AMapSearchAPI alloc] initWithSearchKey:@"57ac3b92223c1c1c3464c39545bc15ec" Delegate:self];
    
}

- (void)searchPlaceByAroundWithLocation:(AMapGeoPoint *)location
{
    AMapPlaceSearchRequest *poiRequest = [[AMapPlaceSearchRequest alloc] init];
    poiRequest.searchType = AMapSearchType_PlaceAround;
    poiRequest.location = location;
    poiRequest.keywords = @"兴业银行";
    poiRequest.radius = 2000;
    [self.searchMap AMapPlaceSearch:poiRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    
    NSUserDefaults * settings1 = [NSUserDefaults standardUserDefaults];
    NSString *key1 = [NSString stringWithFormat:@"is_first"];
    NSString *value = [settings1 objectForKey:key1];

    if (!value){
    
    // 引导页
        MYIntroductionPanel *panel = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"intro1.jpg"] description:@"Welcome to MYIntroductionView, your 100 percent customizable interface for introductions and tutorials! Simply add a few classes to your project, and you are ready to go!"];
    
        MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"intro2.jpg"] description:@"MYIntroductionView is your ticket to a great tutorial or introduction!"];
        
        MYIntroductionPanel *panel3 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"intro3.jpg"] description:@"MYIntroductionView is your ticket to a great tutorial or introduction!"];
    
        MYIntroductionView *introductionView = [[MYIntroductionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WITH, SCREEN_HEIGHT+20) panels:@[panel, panel2, panel3]];
    
        introductionView.delegate = self;
    
        [introductionView showInView:self.view];
        
        NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
        NSString * key = [NSString stringWithFormat:@"is_first"];
        [setting setObject:[NSString stringWithFormat:@"false"] forKey:key];
        [setting synchronize];
    }
}

// 创建三级菜单
- (void)createThirdMenuView
{
    
    for (UIView *view in self.ThirdMenuView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    
    // 第三级菜单按钮
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 5; j++) {
            if ((i*5+j) >= self.thirdMenuArray.count) {
                break;
            }
            UIUrlButton *btnThirdMenu = [UIUrlButton buttonWithType:UIButtonTypeSystem];
            btnThirdMenu.frame = CGRectMake(self.ThirdMenuView.frame.size.width/5*j, self.ThirdMenuView.frame.size.height/4*i, self.ThirdMenuView.frame.size.width/5, self.ThirdMenuView.frame.size.height/4);
            NSDictionary *oneThirdMenuInfo = self.thirdMenuArray[i*5+j];
            [btnThirdMenu setTitle:[oneThirdMenuInfo objectForKey:@"name"] forState:UIControlStateNormal];
            btnThirdMenu.urlString = [oneThirdMenuInfo objectForKey:@"url"];
            [btnThirdMenu addTarget:self action:@selector(doBtnThirdMenu:) forControlEvents:UIControlEventTouchUpInside];
            [self.ThirdMenuView addSubview:btnThirdMenu];
        }
    }
}

// 三级菜单相应方法
- (void)doBtnThirdMenu:(UIUrlButton *)sender
{
    [self loadRequestWithWebView:self.mainWebView urlStr:sender.urlString];
    [self webViewChangeRightToLeft];
}

//退出应用
- (void)exitApplication {
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    UIWindow *window = app.window;
    
    [UIView animateWithDuration:0.8f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(SCREEN_HEIGHT/2, SCREEN_WITH/2, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

//加载对应webview的网页链接
//-(void)loadUrl:(UIWebView *)webview url:(NSString *)url{
//    if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) {
//        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:TIMER_OUT_SECOND]];
//    }else{
//        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:url]]];
//    }
//}

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

// 载入首页
- (void)loadHomePage
{
#if defined(DEVELOPMENT)
    
    [self loadWebWithSettingKey:@"url"];
    
#else
    
    // TODO:载入首页
    
#endif
    [self webViewChangeRightToLeft];
}

- (BOOL)loadWebWithSettingKey:(NSString *)strKey
{
    NSString *str = [self getStrFromSettingKey:strKey];
    if (str == nil) {
        return NO;
    }
    NSLog(@"%@ == %@",strKey,str);
    [self loadWebWithStrUrl:str];
    return YES;
}

- (NSString *)getStrFromSettingKey:(NSString *)strKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    NSString *strUrl = [defaults objectForKey:strKey];
    return strUrl;
}

- (void)loadWebWithStrUrl:(NSString *)strUrl
{
    /*
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    BOOL isClear = [defaults objectForKey:@"clearCache"];
    if (isClear) {
        [[NSURLCache sharedURLCache] removeAllCachedResponses]; // 清空缓存
    }*/

    [self loadRequestWithWebView:self.mainWebView urlStr:strUrl];
}

- (IBAction)doBtnHomePage:(id)sender {
    [self loadHomePage];
}


- (IBAction)doBtnLogin:(id)sender {
    //[[BasicPlugin getInstance]executePluginByUrl:@"callfunction://callbackId=WebViewPluginopenViewEvent&className=WebViewPlugin&method=openView&params=http%3A%2F%2Fnews.qq.com%24800%24500&currentPage=rindex.html&tt=1418005658128" tag:1]; // 打开网页弹窗
    
    //callfunction://callbackId=WebViewPlugincloseViewEvent&className=WebViewPlugin&method=closeView&params=&currentPage=rindex.html&tt=1418025732006   //关闭弹窗
    
    //[[BasicPlugin getInstance] executePluginByUrl:@"callfunction://callbackId=DatePlugingetDateEvent&className=DatePlugin&method=getOneDate&params=2014-12-20$2014-12-25&currentPage=rindex.html&tt=1418115067320" tag:1];  //获取单个日期
    
    // 平移动画, 从左到右
    //[[BasicPlugin getInstance] executePluginByUrl:@"callfunction://callbackId=TransformPluginTranslationEvent&className=TransformPlugin&method=translationWebFromLeftToRight&params=0" tag:1];
    //[[BasicPlugin getInstance] executePluginByUrl:@"callfunction://callbackId=TransformPluginChangeLoginBtnTitleEvent&className=TransformPlugin&method=changeLoginBtnTitle&params=logined$1" tag:1];
    //[[BasicPlugin getInstance] executePluginByUrl:@"callfunction://callbackId=TransformPluginChangeLoginBtnTitleEvent&className=TransformPlugin&method=changeLoginBtnTitle&params=loginOut$0" tag:0];
    //changeLoginBtnTitle
    //[self loadRequestWithWebView:self.mainWebView urlStr:@"https://168.3.27.52/pad/main/transfer/innerTransfer.do?FUNID=TOP01|FIN01|FIN01_01"];
    
    if (((UIButton *)sender).tag == 0) {
        // 未登录
    }else{
        // 已登录
    }
    //showMap
    [[BasicPlugin getInstance] executePluginByUrl:@"callfunction://callbackId=TransformPluginShowMapEvent&className=TransformPlugin&method=showMap&params=0" tag:1];
    //[[BasicPlugin getInstance] executePluginByUrl:@"callfunction://callbackId=TransformPluginDismissMapEvent&className=TransformPlugin&method=dismissMap&params=0" tag:1];
}

- (void)loadLocalErrorWithWebView:(UIWebView *)webView
{
    [webView stopLoading];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"www" ofType:nil];
    NSString *filePath = [path stringByAppendingPathComponent:@"/html/common/error1.html"];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
}

- (void)loadRequestWithWebView:(UIWebView *)webView urlStr:(NSString *)urlStr
{
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:TIMER_OUT_SECOND]];
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
//        UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
//        backView.backgroundColor = [UIColor colorWithRed:233/255.0 green:254/255.0 blue:250/255.0 alpha:1.0];
//        cell.selectedBackgroundView = backView;
        cell.textLabel.text = [self.firstMenuArray[indexPath.row] objectForKey:@"name"];  // FIXME:测试数据
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
    }else if (tableView == self.secondMenuTableView){
        cell = [tableView dequeueReusableCellWithIdentifier:@"secondMenuCell"];
        cell.textLabel.text = [self.secondMenuArray[indexPath.row] objectForKey:@"name"]; // FIXME:测试数据
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
        
        self.secondMenuArray = [self.firstMenuArray[indexPath.row] objectForKey:@"child"];
        [self.secondMenuTableView reloadData];
        
    }else if (tableView == self.secondMenuTableView){
        self.thirdMenuArray = [self.secondMenuArray[indexPath.row] objectForKey:@"child"];
        [self createThirdMenuView];
        [self webViewChangeLeftToRight];
        [self dismissMap];
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
    //[[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    NSString *url = [request.URL absoluteString];
    NSLog(@"should url = %@ webView.tag = %ld",url,webView.tag);
    
    if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) {
        
    }else if([url hasPrefix:CALLFUNCTION_PREFIX]){
        NSLog(@"webView.tag = %ld",webView.tag);
        [[BasicPlugin getInstance]executePluginByUrl:url tag:webView.tag];
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityView startAnimat];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityView stopAnimat];
    
    if (self.isFirstConnectNet) {
        self.isFirstConnectNet = NO;
    }
    NSLog(@"载入网页成功!\n[%@]\n",webView.request.URL.absoluteString);
    
    
#if defined(DEVELOPMENT)
    
    // TODO:从网页获取地址
    NSString *getStr = [webView stringByEvaluatingJavaScriptFromString:@"menujson"];
    
    // 若页面取不到 menujson 字符串, 使用本地 plist 文件内容
    if (!getStr||[getStr isEqualToString:@""]) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"MenuList" withExtension:@"plist"]];
        
        self.firstMenuArray = [dic objectForKey:@"menuList"];
        if (self.secondMenuArray.count == 0) {
            self.secondMenuArray = [[self.firstMenuArray objectAtIndex:0] valueForKey:@"child"];
        }
        if (self.thirdMenuArray.count == 0) {
            self.thirdMenuArray = [[self.secondMenuArray objectAtIndex:0] valueForKey:@"child"];
        }
        
        [self.firstMenuTableView reloadData];
        [self.secondMenuTableView reloadData];
        
        
    }else{
        NSData *data = [getStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dicList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (dicList.count != 0) {
            self.firstMenuArray = [dicList objectForKey:@"menuList"];
            if (self.secondMenuArray.count == 0) {
                self.secondMenuArray = [[self.firstMenuArray objectAtIndex:0] valueForKey:@"child"];
            }
            if (self.thirdMenuArray.count == 0) {
                self.thirdMenuArray = [[self.secondMenuArray objectAtIndex:0] valueForKey:@"child"];
            }
        }
        [self.firstMenuTableView reloadData];
        [self.secondMenuTableView reloadData];
    }
    
#else
    NSString *getStr = [webView stringByEvaluatingJavaScriptFromString:@"menujson"];
    NSData *data = [getStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dicList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if (dicList.count != 0) {
        self.firstMenuArray = [dicList objectForKey:@"menuList"];
        if (self.secondMenuArray.count == 0) {
            self.secondMenuArray = [[self.firstMenuArray objectAtIndex:0] valueForKey:@"child"];
        }
        if (self.thirdMenuArray.count == 0) {
            self.thirdMenuArray = [[self.secondMenuArray objectAtIndex:0] valueForKey:@"child"];
        }
    }
    [self.firstMenuTableView reloadData];
    [self.secondMenuTableView reloadData];
    
#endif
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityView stopAnimat];
    
    if (![webView.request.URL.absoluteString hasSuffix:@"error1.html"]) {
        [self loadLocalErrorWithWebView:webView];
    }
    
    if (self.isFirstConnectNet) {
        self.isFirstConnectNet = NO;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"连接服务器超时，确保您的网络连接正常，请重试。" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"重试", nil];
        [alert show];
    }
    NSLog(@"载入网页失败!\n[%@]\n",webView.request.URL.absoluteString);
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: // 退出
        {
            [self.activityView stopAnimat];
            [self exitApplication];
        }
            break;
        case 1:  // 重试
        {
            // TODO:
            [self loadHomePage];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 页面动画

// 缩小第一级菜单
- (void)shrinkFirstMenu
{
    [UIView animateWithDuration:0.8 animations:^{
        self.isShrink = YES;
        [self.firstMenuTableView setFrame:CGRectMake(0, 69, 55, 654)];
        [self.firstMenuTableView setRowHeight:55];
    }];
}

// 放大第一级菜单
- (void)enlargeFirstMenu
{
    [UIView animateWithDuration:0.8 animations:^{
        self.isShrink = NO;
        [self.firstMenuTableView setFrame:CGRectMake(0, 69, 191, 654)];
        [self.firstMenuTableView setRowHeight:164];
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



#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
{
    [self searchPlaceByAroundWithLocation:[AMapGeoPoint locationWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude]];
    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[POIAnnotation class]])
    {
        static NSString *poiIdentifier = @"poiIdentifier";
        MAPinAnnotationView *poiAnnotationView = (MAPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:poiIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:poiIdentifier];
        }
        
        poiAnnotationView.canShowCallout = YES;
        
        return poiAnnotationView;
    }
    
    return nil;
}

#pragma mark - AMapSearchDelegate
- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response
{
    //NSLog(@"搜索结果 = %@",response.pois);
    //[self initAnnotationsWithResponse:response.pois];
    if (response.pois.count == 0) {
        return;
    }
    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:response.pois.count];
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        [poiAnnotations addObject:[[POIAnnotation alloc] initWithPOI:obj]];
    }];
    [self.mapView addAnnotations:poiAnnotations];
    //[self.mapView showAnnotations:poiAnnotations animated:YES];
}

@end
