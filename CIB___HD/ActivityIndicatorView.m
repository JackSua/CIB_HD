//
//  ActivityIndicatorView.m
//  YinYin
//
//  Created by  on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ActivityIndicatorView.h"

@implementation ActivityIndicatorView
@synthesize blackView,indicatorView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
         self.backgroundColor = [UIColor clearColor];
        blackView = [[UIView alloc] initWithFrame:CGRectMake(([PublicInfo screenWidth]-80)/2, ([PublicInfo screenHeight]-80)/2, 80, 80)];
        blackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]; //半透明黑色背景
        blackView.layer.cornerRadius = 12; //圆角
        blackView.layer.masksToBounds = YES;
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(5, 55, 80, 15)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:13];
        [title setTextAlignment:NSTextAlignmentCenter];
        title.textColor = [UIColor whiteColor];
        [blackView addSubview:title];
        title.text = @"加载中...";
        
        // 添加等待动作视图
        indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicatorView.frame = CGRectMake((blackView.bounds.size.width - 30) / 2, (blackView.bounds.size.height - 30) / 2 - 10, 30, 30);
        [indicatorView hidesWhenStopped];
        [blackView addSubview:indicatorView];
        [self addSubview:blackView];
  
    }
    return self;
}
-(void)stopAnimat{
    self.hidden = YES;
    [indicatorView stopAnimating];
}
-(void)startAnimat{
    self.hidden = NO;
    [indicatorView startAnimating];
}

@end
