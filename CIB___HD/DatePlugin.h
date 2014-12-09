//
//  DatePlugin.h
//  CIB___HD
//
//  Created by iOS Dev on 14-12-9.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import "CDVPlugin.h"

@interface DatePlugin : CDVPlugin<UIActionSheetDelegate,UIGestureRecognizerDelegate>{
    
    NSString *callbackId;
    UIActionSheet *dateActionsheet;
    NSString *startDateStr;
    UIWebView *webView;
    
    UIView *blackView;
    UIView *emptyView;
}
@property (nonatomic, copy)NSString *startDateStr;
@property (nonatomic, copy) NSString *endDateStr;
@property (nonatomic, strong) UIDatePicker *startDatePicker;
@property (nonatomic, strong) UIDatePicker *endDatePicker;


+(DatePlugin *)shareInstance;

-(void)getDate:(NSMutableArray *)arguments;

@end
