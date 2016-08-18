//
//  NSSet_Kit.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "NSSet_Kit.h"
#import "aycategory_macros.h"

@implementation NSSet (AYSearch)
- (NSSet *)ay_setWithCondition:(BOOL (^)(id _Nonnull))condition{
    NSMutableSet *result = [NSMutableSet set];
    for (id obj in self) {
        doIf(condition(obj), [result addObject:obj]);
    }
    return result;
}

- (NSSet *)ay_removeWithCondition:(BOOL (^)(id _Nonnull))condition{
    NSMutableSet *result = [self mutableCopy];
    for (id obj in self) {
        doIf(condition(obj), [result removeObject:obj]);
    }
    return result;
}

- (NSSet *)ay_setInSet:(NSSet *)set{
    NSMutableSet *result = [NSMutableSet new];
    for (id obj in set) {
        doIf([self containsObject:obj], [result addObject:obj]);
    }
    return result;
}
@end

@implementation NSSet (Kit)
- (NSString *)ay_join:(NSString *)separator{
    NSMutableString *result = [NSMutableString new];
    for (id value in self) {
        doIf(result.length, [result appendString:separator]);
        [result appendFormat:@"%@", value];
    }
    return result;
}

- (NSArray *)ay_toArray{
    NSMutableArray *result = [NSMutableArray new];
    for (id obj in self) {
        [result addObject:obj];
    }
    return result;
}

- (NSMutableArray *)ay_toMutableArray{
    NSMutableArray *result = [NSMutableArray new];
    for (id obj in self) {
        [result addObject:obj];
    }
    return result;
}
@end
