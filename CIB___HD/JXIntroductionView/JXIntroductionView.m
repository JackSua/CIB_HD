//
//  JXIntroductionView.m
//  CIB___HD
//
//  Created by iOS Dev on 14-12-11.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import "JXIntroductionView.h"
#import "PublicInfo.h"

@implementation JXIntroductionView

- (id)initWithFrame:(CGRect)frame images:(NSArray *)images
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.contentSize = CGSizeMake(SCREEN_WITH, SCREEN_HEIGHT+20);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsVerticalScrollIndicator = YES;
    }
    return self;
}



@end
