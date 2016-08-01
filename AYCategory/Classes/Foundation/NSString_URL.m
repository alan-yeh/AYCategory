//
//  NSString_URL.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "NSString_URL.h"

@implementation NSString (AY_URL)
-(NSString *)ay_URLEncoding{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}
- (NSString *)ay_URLDecoding{
    NSMutableString * string = [NSMutableString stringWithString:self];
    [string replaceOccurrencesOfString:@"+"
                            withString:@" "
                               options:NSLiteralSearch
                                 range:NSMakeRange(0, [string length])];
    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
- (NSString *)ay_URLParamForKey:(NSString *)aKey{
    //先URLDecode
    NSString *decodedURL = [self ay_URLDecoding];
    
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)", aKey];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:kNilOptions
                                                                             error:&error];
    NSArray *matches = [regex matchesInString:decodedURL
                                      options:0
                                        range:NSMakeRange(0, [decodedURL length])];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [decodedURL substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        return tagValue;
    }
    return nil;
}
@end