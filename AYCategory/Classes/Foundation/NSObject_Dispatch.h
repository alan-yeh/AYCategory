//
//  NSObject_Dispatch.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@interface NSObject (AYDispatch)

- (void)ay_dispatch_sync:(dispatch_block_t)block;/**< 主线程执行Block. */
- (void)ay_dispatch_sync:(dispatch_block_t)block after_delay:(NSTimeInterval)delay;/**< 延迟主线程执行Block. */

- (void)ay_dispatch_async:(dispatch_block_t)block;/**< 异步执行Block. */
- (void)ay_dispatch_async:(dispatch_block_t)block completion:(dispatch_block_t)completion;/**< 延迟主线程执行Block. */

- (void)ay_dispatch_on_new_thread:(dispatch_block_t)block;/**< 开启新线程执行Block */
- (void)ay_dispatch_on_new_thread:(dispatch_block_t)block completion:(dispatch_block_t)completion;/**< 开启新线程执行Block, 任务完成后同步执行completion */

- (void)ay_dispatch_locked:(dispatch_block_t)block;/**< 使用锁执行任务 */

@end
NS_ASSUME_NONNULL_END