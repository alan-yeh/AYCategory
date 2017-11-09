//
//  NSString_Kit.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "NSString_Kit.h"
#import "aycategory_macros.h"

NSString *NSStringWithFormat(NSString *format, ...){
    va_list args;
    va_start(args, format);
    NSString *result = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    return result;
}

@implementation NSString (AY_Kit)
+ (NSString *)ay_randomStringWithLenght:(NSUInteger)lenght{
    char data[lenght];
    for (int x=0;x<lenght;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:lenght encoding:NSUTF8StringEncoding];
}

+ (NSString *)ay_uuidString{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef strRef = CFUUIDCreateString(kCFAllocatorDefault , uuidRef);
    NSString *uuidString = (__bridge NSString*)strRef;
    CFRelease(strRef);
    CFRelease(uuidRef);
    return uuidString;
}

- (BOOL)ay_containsString:(NSString *)aString{
    return [self rangeOfString:aString].location != NSNotFound;
}
- (BOOL)ay_isEquals:(NSString *)anotherString{
    return [self compare:anotherString] == NSOrderedSame;
}
- (BOOL)ay_isEqualsIgnoreCase:(NSString *)anotherString{
    return [self compare:anotherString options:NSCaseInsensitiveSearch] == NSOrderedSame;
}

- (NSInteger)ay_indexOfChar:(unichar)ch{
    return [self ay_indexOfChar:ch fromIndex:0];
}
- (NSInteger)ay_indexOfChar:(unichar)ch fromIndex:(NSInteger)index{
    NSUInteger len = self.length;
    for (NSInteger i = index; i < len; i++) {
        if (ch == [self characterAtIndex:i]) {
            return i;
        }
    }
    return NSNotFound;
}
- (NSInteger)ay_indexOfString:(NSString *)str{
    return [self rangeOfString:str].location;
}
- (NSInteger)ay_indexOfString:(NSString *)str fromIndex:(NSInteger)index{
    return [self rangeOfString:str options:NSLiteralSearch range:NSMakeRange(index, self.length)].location;
}
- (NSInteger)ay_lastIndexOfChar:(unichar)ch{
    return [self ay_lastIndexOfChar:ch fromIndex:self.length - 1];
}
- (NSInteger)ay_lastIndexOfChar:(unichar)ch fromIndex:(NSInteger)index{
    NSAssert(self.length > index, @"index is out of length");
    NSUInteger len = index;
    for (NSInteger i = len - 1; i >= 0; i --) {
        if (ch == [self characterAtIndex:i]) {
            return i;
        }
    }
    return NSNotFound;
}
- (NSInteger)ay_lastIndexOfString:(NSString *)str{
    return [self rangeOfString:str options:NSBackwardsSearch].location;
}
- (NSInteger)ay_lastIndexOfString:(NSString *)str fromIndex:(NSInteger)index{
    return [self rangeOfString:str options:NSBackwardsSearch range:NSMakeRange(0, index)].location;
}
- (NSString *)ay_substringFromIndex:(NSUInteger)from toIndex:(NSUInteger)to{
    return [self substringWithRange:NSMakeRange(from, to - from)];
}
- (NSString *)ay_substringFromIndex:(NSUInteger)from lenght:(NSUInteger)length{
    return [self substringWithRange:NSMakeRange(from, length)];
}

- (NSString *)ay_toLowerCase{
    return [self lowercaseString];
}
- (NSString *)ay_toUpperCase{
    return [self uppercaseString];
}
- (NSString *)ay_firstCharToLowerCase{
    NSString *firstChar = [self substringToIndex:1];
    NSString *otherChars = [self substringFromIndex:1];
    return [[firstChar lowercaseString] stringByAppendingString:otherChars];
}

- (NSString *)ay_firstCharToUpperCase{
    NSString *firstChar = [self substringToIndex:1];
    NSString *otherChars = [self substringFromIndex:1];
    return [[firstChar uppercaseString] stringByAppendingString:otherChars];
}
- (NSString *)ay_trim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
}
- (NSString *)ay_replaceAll:(NSString *)origin with:(NSString *)replacement{
    return [self stringByReplacingOccurrencesOfString:origin withString:replacement ?: @""];
}

- (NSString *)ay_removePrefix:(NSString *)prefix{
    if ([self hasPrefix:prefix]) {
        return [self substringFromIndex:prefix.length];
    }else{
        return self;
    }
}

- (NSString *)ay_removeSuffix:(NSString *)suffix{
    if ([self hasSuffix:suffix]) {
        return [self substringToIndex:self.length - suffix.length];
    }else{
        return self;
    }
}

- (NSArray<NSString *> *)ay_split:(NSString *)separator{
    return [self componentsSeparatedByString:separator];
}

- (NSUInteger)ay_timesAppeard:(NSString *)aString{
    return [self componentsSeparatedByString:aString].count - 1;
}
@end



@implementation NSMutableString (AY_Kit)
- (NSMutableString *)ay_appendString:(NSString *)aString{
    [self appendString:aString];
    return self;
}

- (NSMutableString *)ay_appendFormat:(NSString *)format, ...{
    va_args(format);
    [self appendString:[[NSString alloc] initWithFormat:format arguments:format_args]];
    return self;
}

- (NSMutableString *)ay_subMutableStringFromIndex:(NSUInteger)from toIndex:(NSUInteger)to{
    [self ay_subMutableStringToIndex:to];
    [self ay_subMutableStringFromIndex:from];
    return self;
}

- (NSMutableString *)ay_subMutableStringToIndex:(NSUInteger)to{
    [self deleteCharactersInRange:NSMakeRange(to, self.length - to)];
    return self;
}

- (NSMutableString *)ay_subMutableStringFromIndex:(NSUInteger)from{
    [self deleteCharactersInRange:NSMakeRange(0, from)];
    return self;
}
@end

