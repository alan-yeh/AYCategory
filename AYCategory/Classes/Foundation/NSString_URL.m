//
//  NSString_URL.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "NSString_URL.h"

@implementation NSString (AY_URL)
-(NSString *)ay_URLEncodingWithEncoding:(NSStringEncoding)encoding{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              CFSTR("!*'();:@&=+$,/?%#[] "),
                                                              CFStringConvertNSStringEncodingToEncoding(encoding)));
    return encodedString;
}
- (NSString *)ay_URLDecodingWithEncoding:(NSStringEncoding)encoding{
    NSMutableString * string = [NSMutableString stringWithString:self];
    [string replaceOccurrencesOfString:@"+"
                            withString:@" "
                               options:NSLiteralSearch
                                 range:NSMakeRange(0, [string length])];
    return [string stringByReplacingPercentEscapesUsingEncoding:encoding];
}

@end
