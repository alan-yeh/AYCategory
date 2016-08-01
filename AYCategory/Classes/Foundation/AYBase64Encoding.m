//
//  AYBase64Encoding.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "AYBase64Encoding.h"

@implementation NSString (AYBase64Encoding)
- (NSData *)ay_base64EncodedData{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedDataWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

- (NSData *)ay_base64DecodedData{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data ay_base64DecodedData];
}

- (NSString *)ay_base64EncodedString{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

- (NSString *)ay_base64DecodedString{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:kNilOptions];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
@end


@implementation NSData (AYBase64Encoding)
- (NSString *)ay_base64DecodedString{
    NSData *data = [[NSData alloc] initWithBase64EncodedData:self options:kNilOptions];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)ay_base64EncodedString{
    NSData *data = [self ay_base64EncodedData];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSData *)ay_base64EncodedData{
    return [self base64EncodedDataWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

- (NSData *)ay_base64DecodedData{
    return [[NSData alloc] initWithBase64EncodedData:self options:kNilOptions];
}
@end