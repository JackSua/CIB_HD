//
//  ActivityIndicatorView.m
//  YinYin
//
//  Created by  on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ActivityIndicatorView.h"

@implementation ActivityIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
         self.backgroundColor = [UIColor clearColor];
        _blackView = [[UIView alloc] initWithFrame:CGRectMake(([PublicInfo screenWidth]-80)/2, ([PublicInfo screenHeight]-80)/2, 80, 80)];
        _blackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]; //半透明黑色背景
        _blackView.layer.cornerRadius = 12; //圆角
        _blackView.layer.masksToBounds = YES;
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(5, 55, 80, 15)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:13];
        [title setTextAlignment:NSTextAlignmentCenter];
        title.textColor = [UIColor whiteColor];
        [_blackView addSubview:title];
        title.text = @"加载中...";
        
        // 添加等待动作视图
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicatorView.frame = CGRectMake((_blackView.bounds.size.width - 30) / 2, (_blackView.bounds.size.height - 30) / 2 - 10, 30, 30);
        [_indicatorView hidesWhenStopped];
        [_blackView addSubview:_indicatorView];
        [self addSubview:_blackView];
  
    }
    return self;
}
-(void)stopAnimat{
    self.hidden = YES;
    [_indicatorView stopAnimating];
}
-(void)startAnimat{
    self.hidden = NO;
    [_indicatorView startAnimating];
}

@end
