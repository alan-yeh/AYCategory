//
//  NSUserDefaults_Kit.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSUserDefaults (Kit)
- (void)ay_setObject:(id)value forKey:(NSString *)key;/**< 保存键值对(已同步) */
- (id)ay_objectForKey:(NSString *)key setDefault:(id (^)(void))defaultValue;/**< 获取object，如果没有，添加并返回defaultValue(已同步) */
@end
NS_ASSUME_NONNULL_END
