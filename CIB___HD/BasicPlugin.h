//
//  BasicPlugin.h
//  YinYinForiPad
//
//  Created by chenliang on 2014-08-15
//

#import <Foundation/Foundation.h>
#define EXCEPTION_CALLFUNCTION_PREFIX @"http://callfunction"
#define EXCEPTION_CALLFUNCTION_REPLACE @"callfunction:"
#define CALLFUNCTION_PREFIX @"callfunction://"
@interface BasicPlugin : NSObject

+(BasicPlugin *)getInstance;


-(void)executePluginByUrl:(NSString *)url tag:(NSInteger)tag;

@end
