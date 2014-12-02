//
//  UIUrlButton.m
//  CIB___HD
//
//  Created by iOS Dev on 14-12-2.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import "UIUrlButton.h"

@implementation UIUrlButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.layer.borderWidth = 0.5;
}


@end
