//
//  NSUserDefaults_Kit.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "NSUserDefaults_Kit.h"

@implementation NSUserDefaults (Kit)
- (void)ay_setObject:(id)value forKey:(NSString *)key{
    [self setObject:value forKey:key];
    [self synchronize];
}

- (id)ay_objectForKey:(NSString *)key setDefault:(id _Nonnull (^)())defaultValue{
    return [self objectForKey:key] ?: ({
        id value = defaultValue();
        [self ay_setObject:value forKey:key];
        value;
    });
}
@end
