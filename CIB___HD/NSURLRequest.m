//
//  NSURLRequest.m
//  CIB___HD
//
//  Created by iOS Dev on 14-12-10.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import "NSURLRequest.h"

@implementation NSURLRequest (IgnoreSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}

@end
