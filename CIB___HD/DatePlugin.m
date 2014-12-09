//
//  DatePlugin.m
//  CIB___HD
//
//  Created by iOS Dev on 14-12-9.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import "DatePlugin.h"
#import "UIView+CGAffineTransform.h"
#import "NSMutableArray+QueueAdditions.h"

#define blackView_tag 102
#define emptyView_tag 103
#define UIDatePicker_tag 101
#define UIEndPicker_tag 104
#define UIDatePicker_width 300
#define UIDatePicker_height 220
#define subup 150

static DatePlugin *instance;

@implementation DatePlugin

@synthesize startDateStr,endDateStr,startDatePicker,endDatePicker;

+(DatePlugin *)shareInstance{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}
+(id)allocWithZone:(struct _NSZone *)zone{
    return [DatePlugin shareInstance];
}

-(void)getDate:(NSMutableArray *)arguments
{
    webViewTag = [arguments pop];
    callBackId = [arguments pop];
    webView = mainVC.mainWebView;
    
    blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WITH, SCREEN_HEIGHT+20)];
    blackView.tag = blackView_tag;
    blackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]; //半透明黑色背景
    [blackView setUserInteractionEnabled:YES];
    
    startDatePicker = [[UIDatePicker alloc]init];
    startDatePicker.frame = CGRectMake(0,0, UIDatePicker_width, UIDatePicker_height);
    startDatePicker.backgroundColor = [UIColor whiteColor];
    startDatePicker.datePickerMode = UIDatePickerModeDate;
    startDatePicker.tag = UIDatePicker_tag;
    startDatePicker.minimumDate = [NSDate date];
    
    NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:@"Chinese"];
    [startDatePicker setLocale:locale];
    [startDatePicker addTarget:self action:@selector(startDateChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    endDatePicker = [[UIDatePicker alloc]init];
    endDatePicker.frame = CGRectMake(UIDatePicker_width+50,0, UIDatePicker_width, UIDatePicker_height);
    endDatePicker.backgroundColor = [UIColor whiteColor];
    endDatePicker.datePickerMode = UIDatePickerModeDate;
    endDatePicker.tag = UIEndPicker_tag;
    endDatePicker.minimumDate = [NSDate date];
    
    NSLocale * endlocale = [[NSLocale alloc] initWithLocaleIdentifier:@"Chinese"];
    [endDatePicker setLocale:endlocale];
    [endDatePicker addTarget:self action:@selector(endDateChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    //有传值时
    if (arguments != nil && arguments.count > 0 && [arguments objectAtIndex:0] != [NSNull null] && ![@"NO DATE" isEqualToString:[arguments objectAtIndex:0]] && ![@""isEqualToString:[arguments objectAtIndex:0]] && ![@"undefined"isEqualToString:[arguments objectAtIndex:0]]){
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *dateFromString = [dateFormatter dateFromString:[arguments objectAtIndex:0]];
        [startDatePicker setDate:dateFromString animated:YES];
        startDateStr = [arguments objectAtIndex:0];
        if (arguments.count >1) {
            dateFromString = [dateFormatter dateFromString:[arguments objectAtIndex:1]];
            [endDatePicker setDate:dateFromString animated:YES];
            endDateStr = [arguments objectAtIndex:1];
        }
    }else{
        NSDateFormatter *myFormat = [[NSDateFormatter alloc] init];
        [myFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *date = [myFormat stringFromDate:[startDatePicker date]];
        self.startDateStr = date;
        date = [myFormat stringFromDate:[endDatePicker date]];
        self.endDateStr = date;
    }
    
    
    UIButton *setBtn = [[UIButton alloc]initWithFrame:CGRectMake(startDatePicker.frame.size.width+50,UIDatePicker_height-4, UIDatePicker_width, 40)];
    setBtn.backgroundColor = [UIColor whiteColor];
    [setBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [setBtn setTitleColor:[UIColor colorWithRed:0.416 green:0.463 blue:0.494 alpha:1] forState:UIControlStateHighlighted];
    [setBtn setTitle:@"设置" forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,UIDatePicker_height-4, UIDatePicker_width, 40)];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithRed:0.416 green:0.463 blue:0.494 alpha:1] forState:UIControlStateHighlighted];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    //emptyView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WITH-UIDatePicker_width)/2, subup, UIDatePicker_width*2+50, UIDatePicker_height+40*2)];
    emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, startDatePicker.frame.size.width+50+endDatePicker.frame.size.width, startDatePicker.frame.size.height+40)];
    emptyView.center = CGPointMake(SCREEN_WITH/2, SCREEN_HEIGHT/2);
    emptyView.backgroundColor = [UIColor whiteColor];
    emptyView.tag = emptyView_tag;
    [emptyView addSubview:startDatePicker];
    [emptyView addSubview:endDatePicker];
    [emptyView addSubview:setBtn];
    [emptyView addSubview:cancelBtn];
    
    [webView.superview addSubview:blackView];
    [blackView sadeIn:^{
        [blackView addSubview:emptyView];
        [emptyView show:nil];
    }];
}

#pragma mark - private method
-(void)startDateChanged:(id)sender{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    NSDateFormatter *myFormat = [[NSDateFormatter alloc] init];
    [myFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [myFormat stringFromDate:_date];
    startDateStr = date;
    NSLog(@"startDateStr = %@",startDateStr);
    endDatePicker.minimumDate = _date;
}

-(void)endDateChanged:(id)sender{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    NSDateFormatter *myFormat = [[NSDateFormatter alloc] init];
    [myFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [myFormat stringFromDate:_date];
    endDateStr = date;
    NSLog(@"endDateStr = %@",endDateStr);
    startDatePicker.maximumDate = _date;
}

#pragma mark - click
-(void)sure:(id)sender{
    [self singleTapAction:YES];
    
}
-(void)cancel:(id)sender{
    [self singleTapAction:NO];
}

-(void)singleTapAction:(BOOL)flag{
    NSArray *arr = [webView.superview subviews];
    if(arr!= nil && arr.count>0){
        [emptyView hidden:^{
            if(flag){
                [self executeMethodByCallBackId:[NSString stringWithFormat:@"%@ & %@",startDateStr,endDateStr]];
            }
            [blackView sadeOut:^{
                [blackView removeFromSuperview];
            }];
        }];
    }
}

@end
