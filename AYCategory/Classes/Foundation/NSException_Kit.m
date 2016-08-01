//
//  NSException_Kit.m
//  AYCategory
//
//  Created by PoiSon on 16/8/1.
//
//

#import "NSException_Kit.h"
#import "function.h"
#import "convenientmacros.h"
#import "NSDate_Kit.h"

@implementation NSException (Kit)
+ (instancetype)ay_exceptionWhenExecuting:(const char *)function inFile:(NSString *)fileName atLine:(NSInteger)line description:(NSString *)format, ...{
    va_args(format);
    NSString *reason = [[NSString alloc] initWithFormat:format arguments:format_args];
    AYPrintf(@"❌❌❌❌❌❌❌❌❌❌ Assertion failure ❌❌❌❌❌❌❌❌❌❌\n%@ %s (%@: %@)\n%@\n❌❌❌❌❌❌❌❌❌❌❌❌❌❌ ❌❌❌❌❌❌❌❌❌❌❌❌❌❌\n", [[NSDate new] ay_toString:@"yyyy-MM-dd HH:mm:ss.SSS"], function, [fileName lastPathComponent], @(line), reason);
    
    return [NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:@{@"function": [NSString stringWithUTF8String:function], @"file": fileName, @"lineNumber": @(line)}];
}
@end
