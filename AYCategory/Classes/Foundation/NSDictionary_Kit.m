//
//  NSDictionary_Kit.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "NSDictionary_Kit.h"

@implementation NSDictionary (Kit)
- (id)ay_objectForKey:(id)key useDefault:(id (^)())defaultValue{
    return [self objectForKey:key] ?: defaultValue();
}
- (BOOL)ay_containsKey:(id)key{
    return [[self allKeys] containsObject:key];
}
@end

@implementation NSMutableDictionary (Kit)
- (id)ay_objectForKey:(id)key setDefault:(id (^)())defaultValue{
    return [self objectForKey:key] ?: ({id value = defaultValue(); [self setObject:value forKey:key]; value;});
}
@end
