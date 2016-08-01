//
//  NSObject_Runtime.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(unsigned long, AYStorePolicy){
    AYStoreUsingAssign = 0,/**< weak refernce or assign. */
    AYStoreUsingRetainNonatomic = 1,/**< strong refernce and nonatomic. */
    AYStoreUsingCopyNonatomic = 3,/**< copied and nonatomic. */
    AYStoreUsingRetain = 01401,/**< strong refernce and atomic. */
    AYStoreUsingCopy = 01403/**< copied and atomic. */
};

NS_ASSUME_NONNULL_BEGIN

#define AYAssociatedKey(key)  static void *key = &key
#define AYAssociatedKeyAndNotes(key, notes) static void *key = &key
@interface NSObject (AYRuntime)
+ (BOOL)ay_isSubclassOfClass:(Class)aClass;/**< 判断是否是否个类的子类 */
- (void)ay_notificateWhenDealloc:(void (^)(void))notification;/**< 当dealloc时，执行${notification}. */

- (void)ay_setAssociatedObject:(id)value forKey:(const void *)key usingProlicy:(AYStorePolicy)policy;/**< 使用associatedObject保存数据. */
- (void)ay_setAssociatedObject:(id)value forKey:(const void *)key;/**< 默认使用AYStoreUsingRetainNonatomic策略保存数据 */
- (id)ay_associatedObjectForKey:(const void *)key;/**< 获取associatedObject数据. */
- (id)ay_associatedObjectForKey:(const void *)key storeProlicy:(AYStorePolicy)policy setDefault:(id (^)(void))defaultValue;/**< 获取associatedObject数据，如果没有，则返回defaultValue，并将defaultValue使用策略保存起来. */

+ (void)ay_setAssociatedObject:(id)value forKey:(const void *)key usingProlicy:(AYStorePolicy)policy;
+ (void)ay_setAssociatedObject:(id)value forKey:(const void *)key;
+ (id)ay_associatedObjectForKey:(const void *)key;
+ (id)ay_associatedObjectForKey:(const void *)key storeProlicy:(AYStorePolicy)policy setDefault:(id  _Nonnull (^)(void))defaultValue;
@end
NS_ASSUME_NONNULL_END