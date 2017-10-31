//
//  NSHTTPCookie_Kit.m
//  AYCategory
//
//  Created by Alan Yeh on 2017/10/31.
//

#import "NSHTTPCookie_Kit.h"
#import "NSString_Kit.h"

@implementation NSHTTPCookie (Kit)
- (NSString *)ay_cookieString{
    NSString *result = NSStringWithFormat(@"%@=%@;domain=%@;path=%@", self.name, self.value, self.domain, self.path);
    if (self.isSecure) {
        result = [result stringByAppendingString:@";secure"];
    }
    if (self.isHTTPOnly) {
        result = [result stringByAppendingString:@";HttpOnly"];
    }
    return result;
}
@end

