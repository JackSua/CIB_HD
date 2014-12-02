//
//  ActivityIndicatorView.h
//  YinYin
//
//  Created by  on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PublicInfo.h"

@interface ActivityIndicatorView : UIView
@property(nonatomic, strong)UIActivityIndicatorView *indicatorView;
@property(nonatomic, strong)UIView *blackView;
-(void)stopAnimat;
-(void)startAnimat;
@end
