//
//  NSObject_Runtime.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "NSObject_Runtime.h"
#import "aycategory_macros.h"
#import <AYRuntime/AYRuntime.h>

@implementation NSObject (AYRuntime)

+ (BOOL)ay_isSubclassOfClass:(Class)aClass{
    returnValIf(self.class == aClass, NO);
    return [self isSubclassOfClass:aClass];
}

- (void)ay_setAssociatedObject:(id)value forKey:(const void *)key usingProlicy:(AYStorePolicy)policy{
    objc_setAssociatedObject(self, key, value, (objc_AssociationPolicy)policy);
}

- (void)ay_setAssociatedObject:(id)value forKey:(const void *)key{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)ay_associatedObjectForKey:(const void *)key{
    return objc_getAssociatedObject(self, key);
}

- (id)ay_associatedObjectForKey:(const void *)key storeProlicy:(AYStorePolicy)policy setDefaultBlock:(id (^)(void))defaultValue{
    return objc_getAssociatedDefaultObjectBlock(self, key, (objc_AssociationPolicy)policy, defaultValue);
}

- (id)ay_associatedObjectForKey:(const void *)key setDefaultBlock:(id (^)(void))defaultValue{
    return objc_getAssociatedDefaultObjectBlock(self, key, OBJC_ASSOCIATION_RETAIN_NONATOMIC, defaultValue);
}

- (id)ay_associatedObjectForKey:(const void *)key storeProlicy:(AYStorePolicy)policy setDefault:(id)defaultValue{
    return objc_getAssociatedDefaultObject(self, key, defaultValue, (objc_AssociationPolicy)policy);
}

- (id)ay_associatedObjectForKey:(const void *)key setDefault:(id)defaultValue{
    return objc_getAssociatedDefaultObject(self, key, defaultValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)ay_setAssociatedObject:(id)value forKey:(const void *)key usingProlicy:(AYStorePolicy)policy{
    objc_setAssociatedObject(self, key, value, (objc_AssociationPolicy)policy);
}

+ (void)ay_setAssociatedObject:(id)value forKey:(const void *)key{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (id)ay_associatedObjectForKey:(const void *)key{
    return objc_getAssociatedObject(self, key);
}

+ (id)ay_associatedObjectForKey:(const void *)key storeProlicy:(AYStorePolicy)policy setDefault:(id  _Nonnull (^)(void))defaultValue{
    return objc_getAssociatedDefaultObjectBlock(self, key, (objc_AssociationPolicy)policy, defaultValue);
}

@end