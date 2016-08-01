//
//  NSObject_Runtime.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "NSObject_Runtime.h"
#import "convenientmacros.h"
#import <objc/runtime.h>

@interface AYDeallocNotification : NSObject
@property (nonatomic, strong) NSMutableArray *callbacks;
+ (void)notificateWhenInstanceDelloc:(id)anInstance withCallback:(void (^)(void))callback;
@end

@implementation NSObject (AYRuntime)

+ (BOOL)ay_isSubclassOfClass:(Class)aClass{
    returnValIf(self.class == aClass, NO);
    return [self isSubclassOfClass:aClass];
}

- (void)ay_notificateWhenDealloc:(void (^)(void))notification{
    [AYDeallocNotification notificateWhenInstanceDelloc:self withCallback:notification];
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

- (id)ay_associatedObjectForKey:(const void *)key storeProlicy:(AYStorePolicy)policy setDefault:(id (^)(void))defaultValue{
    return objc_getAssociatedObject(self, key) ?: ({id value = defaultValue(); objc_setAssociatedObject(self, key, value, (objc_AssociationPolicy)policy); value;});
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
    return objc_getAssociatedObject(self, key) ?: ({id value = defaultValue(); objc_setAssociatedObject(self, key, value, (objc_AssociationPolicy)policy); value;});
}

@end

@implementation AYDeallocNotification

+ (void)notificateWhenInstanceDelloc:(id)anInstance withCallback:(void (^)(void))callback{
    AYAssociatedKeyAndNotes(AY_DEALLOC_NOTIFICATION_KEY, @"Store an object to target, when the target dealloc, this object is dealloc either.");
    AYDeallocNotification *notification = [anInstance ay_associatedObjectForKey:AY_DEALLOC_NOTIFICATION_KEY storeProlicy:AYStoreUsingRetainNonatomic setDefault:^id{
        return [AYDeallocNotification new];
    }];
    [notification.callbacks addObject:callback];
}

- (instancetype)init{
    if (self = [super init]) {
        _callbacks = [NSMutableArray new];
    }
    return self;
}

- (void)dealloc{
    for (id callbackObj in self.callbacks) {
        void (^callback)(void) = (void (^)(void))callbackObj;
        callback();
    }
}
@end