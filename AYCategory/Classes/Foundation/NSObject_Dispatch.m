//
//  NSObject_Dispatch.m
//  AYCategory
//
//  Created by PoiSon on 16/8/1.
//
//

#import "NSObject_Dispatch.h"
#import "NSString_Kit.h"
#import "convenientmacros.h"
#import <libkern/OSAtomic.h>


@implementation NSObject (AYDispatch)
- (void)ay_performBlockSync:(dispatch_block)block{
    dispatch_async(dispatch_get_main_queue(), block);
}

- (void)ay_performBlockSync:(dispatch_block)block afterDelay:(NSTimeInterval)delay{
    [self performSelector:@selector(ay_performBlockSync:) withObject:block afterDelay:delay];
}

- (void)ay_performBlockAsync:(dispatch_block)block{
    [self _ay_execute_block:block on_queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) completion:nil];
}

- (void)ay_performBlockAsync:(dispatch_block)block completion:(dispatch_block)completion{
    [self _ay_execute_block:block on_queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) completion:nil];
}

- (void)ay_performBlockOnNewThread:(dispatch_block)block{
    [self _ay_execute_block:block on_queue:dispatch_queue_create([[@"AY_ASYNC_THREAD_" stringByAppendingString:[NSString ay_randomStringWithLenght:8]] UTF8String], NULL) completion:nil];
}

- (void)ay_performBlockOnNewThread:(dispatch_block)block completion:(dispatch_block)completion{
    [self _ay_execute_block:block on_queue:dispatch_queue_create([[@"AY_ASYNC_THREAD_" stringByAppendingString:[NSString ay_randomStringWithLenght:8]] UTF8String], NULL) completion:completion];
}

- (void)_ay_execute_block:(dispatch_block)block on_queue:(dispatch_queue_t)queue completion:(dispatch_block)completion{
    dispatch_async(queue, ^{
        block();
        doIf(completion, [self ay_performBlockSync:completion]);
    });
}

- (void)ay_performBlockLocked:(dispatch_block)block{
    static OSSpinLock aspect_lock = OS_SPINLOCK_INIT;
    OSSpinLockLock(&aspect_lock);
    block();
    OSSpinLockUnlock(&aspect_lock);
}
@end