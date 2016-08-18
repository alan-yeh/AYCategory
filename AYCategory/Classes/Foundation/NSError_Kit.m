//
//  NSError_Kit.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "NSError_Kit.h"
#import "NSBundle_Kit.h"
#import "aycategory_macros.h"

@implementation NSError (AYKit)
+ (instancetype)ay_errorWithLocalizedDescription:(NSString *)description{
    static NSString *domain;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        domain = [NSBundle mainBundle].infoDictionary[AYBundleName];
        domain = domain ?: @"none domain";
    });
    return [self errorWithDomain:domain code:-1000 userInfo:@{NSLocalizedDescriptionKey: description}];
}

+ (instancetype)ay_errorWhenExecuting:(const char *)function inFile:(NSString *)fileName atLine:(NSInteger)line description:(NSString *)format, ...{
    static NSString *domain;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        domain = [NSBundle mainBundle].infoDictionary[AYBundleName];
        domain = domain ?: @"none domain";
    });
    
    va_args(format);
    NSString *reason = [[NSString alloc] initWithFormat:format arguments:format_args];
    
    return [self errorWithDomain:domain code:-1000 userInfo:@{
                                                              NSLocalizedDescriptionKey: reason,
                                                              @"Function": @(function),
                                                              @"Line": @(line),
                                                              @"FileName": [fileName lastPathComponent]
                                                              }];
}
@end

NSError *NSErrorWithLocalizedDescription(NSString *description){
    return [NSError ay_errorWithLocalizedDescription:description];
}