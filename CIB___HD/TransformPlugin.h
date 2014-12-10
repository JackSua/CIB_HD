//
//  TransformPlugin.h
//  CIB___HD
//
//  Created by iOS Dev on 14-12-10.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import "CDVPlugin.h"

@interface TransformPlugin : CDVPlugin

+(TransformPlugin *)shareInstance;

- (void)translationWebFromLeftToRight:(NSMutableArray *)arguments;

@end
