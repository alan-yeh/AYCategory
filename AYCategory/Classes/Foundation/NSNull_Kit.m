//
//  NSNull_Kit.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "NSNull_Kit.h"
#import "convenientmacros.h"

@implementation NSNull (Safe)

static BOOL _ay_enabled = NO;
+ (void)ay_setNullSafeEnabled:(BOOL)enabled{
    _ay_enabled = enabled;
}
- (id)forwardingTargetForSelector:(SEL)aSelector{
    returnValIf(!_ay_enabled, nil);
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    returnValIf(!_ay_enabled, nil);
    
    static NSMethodSignature *signature;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        signature = [NSMethodSignature signatureWithObjCTypes:"@@:"];
    });
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    id target = nil;
    [anInvocation invokeWithTarget:target];
}
@end
