//
//  JXIntroductionView.h
//  CIB___HD
//
//  Created by iOS Dev on 14-12-11.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXIntroductionView : UIView<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) NSArray *imagesTitles;

@end
