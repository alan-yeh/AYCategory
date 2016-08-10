//
//  NSObject_Dispatch.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "NSObject_Dispatch.h"
#import "NSString_Kit.h"
#import "convenientmacros.h"
#import <libkern/OSAtomic.h>


@implementation NSObject (AYDispatch)
- (void)ay_dispatch_sync:(dispatch_block_t)block{
    dispatch_async(dispatch_get_main_queue(), block);
}

-(void)ay_dispatch_sync:(dispatch_block_t)block after_delay:(NSTimeInterval)delay{
    [self performSelector:@selector(ay_dispatch_sync:) withObject:block afterDelay:delay];
}

- (void)ay_dispatch_async:(dispatch_block_t)block{
    [self _ay_execute_block:block on_queue:dispatch_get_global_queue(0, 0) completion:nil];
}

- (void)ay_dispatch_async:(dispatch_block_t)block completion:(dispatch_block_t)completion{
    [self _ay_execute_block:block on_queue:dispatch_get_global_queue(0, 0) completion:completion];
}

- (void)ay_dispatch_on_new_thread:(dispatch_block_t)block{
    [self _ay_execute_block:block on_queue:dispatch_queue_create([[@"AY_ASYNC_THREAD_" stringByAppendingString:[NSString ay_randomStringWithLenght:8]] UTF8String], NULL) completion:nil];
}

- (void)ay_dispatch_on_new_thread:(dispatch_block_t)block completion:(dispatch_block_t)completion{
    [self _ay_execute_block:block on_queue:dispatch_queue_create([[@"AY_ASYNC_THREAD_" stringByAppendingString:[NSString ay_randomStringWithLenght:8]] UTF8String], NULL) completion:completion];
}


- (void)_ay_execute_block:(dispatch_block_t)block on_queue:(dispatch_queue_t)queue completion:(dispatch_block_t)completion{
    dispatch_async(queue, ^{
        block();
        doIf(completion, [self ay_dispatch_sync:completion]);
    });
}

- (void)ay_performBlockLocked:(dispatch_block_t)block{
    static OSSpinLock aspect_lock = OS_SPINLOCK_INIT;
    OSSpinLockLock(&aspect_lock);
    block();
    OSSpinLockUnlock(&aspect_lock);
}
@end