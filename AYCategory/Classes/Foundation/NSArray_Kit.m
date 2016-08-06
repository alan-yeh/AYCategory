//
//  NSArray_Kit.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "NSArray_Kit.h"
#import "convenientmacros.h"

@implementation NSArray (AYSearch)
- (NSArray *)ay_arrayWithCondition:(BOOL (^)(id _Nonnull))condition{
    NSMutableArray *result = [NSMutableArray new];
    for (id obj in self) {
        doIf(condition(obj), [result addObject:obj]);
    }
    return result;
}

- (NSArray *)ay_removeWithCondition:(BOOL (^)(id _Nonnull))condition{
    NSMutableArray *result = [self mutableCopy];
    for (id obj in self) {
        doIf(condition(obj), [result removeObject:obj]);
    }
    return result;
}

- (NSArray *)ay_arrayInArray:(NSArray *)array{
    NSMutableArray *result = [NSMutableArray new];
    for (id obj in array) {
        doIf([self containsObject:obj], [result addObject:obj]);
    }
    return result;
}
@end

@implementation NSArray (Kit)
- (NSArray *)ay_objectsBeforIndex:(NSUInteger)index{
    if (self.count < index) {
        return self;
    }else{
        return [self subarrayWithRange:NSMakeRange(0, index)];
    }
}

- (NSArray *)ay_objectsAfterIndex:(NSUInteger)index{
    if (self.count < index) {
        return self;
    }else{
        return [self subarrayWithRange:NSMakeRange(self.count - index, index)];
    }
}

- (NSArray *)ay_objectsInRange:(NSRange)range{
    return [self subarrayWithRange:range];
}

- (instancetype)reverse{
    return [NSMutableArray ay_arrayWithEnumerator:self.reverseObjectEnumerator];
}

- (NSString *)ay_join:(NSString *)separator{
    NSMutableString *result = [NSMutableString new];
    for (id value in self) {
        doIf(result.length, [result appendString:separator]);
        [result appendFormat:@"%@", value];
    }
    return result;
}

- (NSSet *)ay_toSet{
    return [NSSet setWithArray:self];
}

- (NSMutableSet *)ay_toMutableSet{
    return [NSMutableSet setWithArray:self];
}

- (instancetype)ay_initWithEnumerator:(NSEnumerator *)enumerator{
    NSMutableArray *array = [NSMutableArray array];
    id obj;
    while ((obj = enumerator.nextObject)) {
        [array addObject:obj];
    }
    return array;
}

+ (instancetype)ay_arrayWithEnumerator:(NSEnumerator *)enumerator{
    return [[self alloc] ay_initWithEnumerator:enumerator];
}

@end

@implementation NSMutableArray (Kit)
- (void)ay_removeObjectsFormArray:(NSArray *)array{
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self removeObject:obj];
    }];
}

- (void)ay_replaceObject:(id)obj withObjec:(id)anotherObj{
    if ([self containsObject:obj]) {
        [self replaceObjectAtIndex:[self indexOfObject:obj] withObject:anotherObj];
    }
}

- (void)ay_moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex{
    NSAssert(fromIndex < self.count && fromIndex >= 0, @"fromIndex out of bounds");
    NSAssert(toIndex < self.count && toIndex >= 0, @"toIndex out of bounds");
    id obj = [self objectAtIndex:fromIndex];
    [self removeObjectAtIndex:fromIndex];
    [self insertObject:obj atIndex:toIndex];
}

- (void)ay_insertObjectAtFirst:(id)obj{
    [self insertObject:obj atIndex:0];
}

- (void)ay_insertObjectsAtFirst:(NSArray *)array{
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:array];
    [newArray addObject:self];
    [self removeAllObjects];
    [self addObjectsFromArray:newArray];
}

- (id)ay_removeFirstObject{
    id obj = nil;
    if (self.count) {
        obj = [self objectAtIndex:0];
        [self removeObjectAtIndex:0];
    }
    return obj;
}

- (NSArray *)ay_removeFirstObjects:(NSUInteger)count{
    NSMutableArray *removedObjects = [NSMutableArray new];
    if (count >= self.count) {
        [removedObjects addObjectsFromArray:self];
        [self removeAllObjects];
    }else {
        [removedObjects addObjectsFromArray:[self ay_objectsInRange:NSMakeRange(0, count)]];
        [self removeObjectsInRange:NSMakeRange(0, count)];
    }
    return removedObjects;
}

- (void)ay_addObject:(id)obj{
    [self addObject:obj];
}

- (void)ay_addObjects:(NSArray *)array{
    [self addObjectsFromArray:array];
}

- (id)ay_removeLastObject{
    id lastObject = nil;
    if (self.count) {
        lastObject = [self lastObject];
        [self removeLastObject];
    }
    return lastObject;
}

- (NSArray *)ay_removeLastObjects:(NSUInteger)count{
    NSMutableArray *removedObjects = [NSMutableArray new];
    if (count >= self.count) {
        [removedObjects addObjectsFromArray:self];
        [self removeAllObjects];
    }else{
        [removedObjects addObjectsFromArray:[self ay_objectsInRange:NSMakeRange(self.count - count, count)]];
        [self removeObjectsInRange:NSMakeRange(self.count - count, count)];
    }
    return removedObjects;
}

- (void)ay_addObjectsFormEnumerator:(NSEnumerator *)enumerator{
    id obj;
    while ((obj = enumerator.nextObject)) {
        [self addObject:obj];
    }
}
@end