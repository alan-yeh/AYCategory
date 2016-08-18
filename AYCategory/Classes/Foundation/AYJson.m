//
//  AYJson.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "AYJson.h"
#import "aycategory_macros.h"

@implementation NSString (Json)
- (id)ay_jsonContainer{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ay_jsonContainer];
}

- (NSArray *)ay_jsonArray{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ay_jsonArray];
}

- (NSDictionary *)ay_jsonDictionary{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ay_jsonDictionary];
}

- (id)ay_jsonMutableContainer{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ay_jsonMutableContainer];
}

- (NSMutableArray *)ay_jsonMutableArray{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ay_jsonMutableArray];
}

- (NSMutableDictionary *)ay_jsonMutableDictionary{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ay_jsonMutableDictionary];
}
@end

@implementation NSDictionary (Json)
- (NSData *)ay_toJsonData{
    NSData *result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:nil];
    return result;
}

- (NSString *)ay_toJsonString{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:nil];
    return data == nil ? nil : [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
@end

@implementation NSArray (Json)
- (NSData *)ay_toJsonData{
    NSData *result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:nil];
    return result;
}

- (NSString *)ay_toJsonString{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:nil];
    return data == nil ? nil : [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
@end

@implementation NSData (Json)
- (id)ay_jsonContainer{
    NSData *result = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:nil];
    return result;
}

- (NSArray *)ay_jsonArray{
    id result = [self ay_jsonContainer];
    returnValIf(!result, nil);
    NSAssert([result isKindOfClass:[NSArray class]], @"cant conver data to NSArray, target is '%@'", [result class]);
    return result;
}

- (NSDictionary *)ay_jsonDictionary{
    id result = [self ay_jsonContainer];
    returnValIf(!result, nil);
    NSAssert([result isKindOfClass:[NSDictionary class]], @"cant conver data to NSDictionary, target is '%@'", [result class]);
    return result;
}

- (id)ay_jsonMutableContainer{
    id result = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:nil];
    return result;
}

- (NSMutableArray *)ay_jsonMutableArray{
    id result = [self ay_jsonMutableContainer];
    returnValIf(!result, nil);
    NSAssert([result isKindOfClass:[NSMutableArray class]], @"cant conver data to NSMutableArray, target is '%@'", [result class]);
    return result;
}

- (NSMutableDictionary *)ay_jsonMutableDictionary{
    id result = [self ay_jsonMutableContainer];
    returnValIf(!result, nil);
    NSAssert([result isKindOfClass:[NSMutableDictionary class]], @"cant conver data to NSMutableDictionary, target is '%@'", [result class]);
    return result;
}
@end