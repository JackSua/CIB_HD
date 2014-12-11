//
//  BasicPlugin.m
//  YinYinForiPad
//
//  Created by chenliang on 2014-08-15
//

#import "BasicPlugin.h"
//#import "FullScreenPlugin.h"

static BasicPlugin *instance;
@implementation BasicPlugin

+(BasicPlugin *)getInstance{
    @synchronized(self){
        if(instance == nil){
            instance = [[BasicPlugin alloc]init];
        }
    }
    return instance;
}

-(void)executePluginByUrl:(NSString *)url tag:(NSInteger)tag{
    NSRange range = [url rangeOfString:CALLFUNCTION_PREFIX];
    NSString *temp = [url substringFromIndex:range.location + range.length];
    NSArray *arr = [temp componentsSeparatedByString:@"&"];
    
    NSString *callBackId = @"";
    NSString *className = @"";
    NSString *methodName = @"";
    NSMutableArray *params = [NSMutableArray arrayWithCapacity:0];
    
    if(arr != nil && arr.count > 0){
        NSString *tt = [arr objectAtIndex:0];
        NSArray *tempArr = [tt componentsSeparatedByString:@"="];
        callBackId = [tempArr objectAtIndex:1];
        
        tt = [arr objectAtIndex:1];
        tempArr = [tt componentsSeparatedByString:@"="];
        className = [tempArr objectAtIndex:1];
        
        tt = [arr objectAtIndex:2];
        tempArr = [tt componentsSeparatedByString:@"="];
        methodName = [tempArr objectAtIndex:1];
        
        tt = [arr objectAtIndex:3];
        tempArr = [tt componentsSeparatedByString:@"="];
        NSString *paramStr = [tempArr objectAtIndex:1];
        paramStr = [paramStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if(paramStr != nil && paramStr.length > 0){
            params = [NSMutableArray arrayWithArray:[paramStr componentsSeparatedByString:@"$"]];
        }

        //反射调用有参方法
        NSMutableArray *pp = [NSMutableArray arrayWithCapacity:0];
        [pp addObject:[NSString stringWithFormat:@"%ld",tag]];
        [pp addObject:callBackId];
        for(NSString *t in params){
            [pp addObject:t];
        }
        
        Class cls = NSClassFromString(className);
        id a= [[cls  alloc]  init];
        SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@%@",methodName,@":"]);
        if([a respondsToSelector:selector]){
            @try {
                [a performSelector:selector withObject:pp];
            }@catch (NSException *exception) {
                NSLog(@"exception.name=%@,exception.reason=%@",exception.name,exception.reason);
                NSLog(@"BasicPlugin: class:%@'s method:%@ is not found.",className,methodName);
            }
        }
    }
    
}

@end
