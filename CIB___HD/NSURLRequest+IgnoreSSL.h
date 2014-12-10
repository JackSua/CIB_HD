//
//  NSURLRequest+IgnoreSSL.h
//  CIB___HD
//
//  Created by iOS Dev on 14-12-10.
//  Copyright (c) 2014年 iOS Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (IgnoreSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;

@end
