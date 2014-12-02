//
//  UIUrlButton.h
//  CIB___HD
//
//  Created by iOS Dev on 14-12-2.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIUrlButton : UIButton

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *urlString;

@end
