//
//  NSURL_Kit.m
//  AYCategory
//
//  Created by Alan Yeh on 2017/10/12.
//

#import "NSURL_Kit.h"
#import "NSString_URL.h"

@implementation NSURL (Kit)
- (NSString *)ay_decodedString{
    return [self.absoluteString ay_URLDecodingWithEncoding:NSUTF8StringEncoding];
}

+ (NSURL *)ay_URLWithString:(NSString *)URLString{
    NSString *decode = [URLString ay_URLDecodingWithEncoding:NSUTF8StringEncoding];
    if (decode == nil) {
        // 在国内，蛮多程序员会使用GBK来做URL编码的，这个是用来做预防手段
        decode = [URLString ay_URLDecodingWithEncoding:NSGBKStringEncoding];
    }
    
    decode = [decode ay_URLEncodingWithEncoding:NSUTF8StringEncoding];
    
    return [NSURL URLWithString:decode];
}

+ (NSURL *)ay_URLWithString:(NSString *)URLString relativeToURL:(NSURL *)baseURL{
    NSString *decode = [URLString ay_URLDecodingWithEncoding:NSUTF8StringEncoding];
    if (decode == nil) {
        // 在国内，蛮多程序员会使用GBK来做URL编码的，这个是用来做预防手段
        decode = [URLString ay_URLDecodingWithEncoding:NSGBKStringEncoding];
    }
    
    decode = [decode ay_URLEncodingWithEncoding:NSUTF8StringEncoding];
    
    return [NSURL URLWithString:decode relativeToURL:baseURL];
}
@end
