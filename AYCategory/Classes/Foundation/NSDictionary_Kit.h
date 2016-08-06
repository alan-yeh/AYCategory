//
//  NSDictionary_Kit.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSDictionary<KeyType, ObjectType> (Kit)
- (nullable ObjectType)ay_objectForKey:(KeyType)key useDefault:(ObjectType (^)())defaultValue;/**< 获取object，如果没有返回defaultValue. */
- (BOOL)ay_containsKey:(KeyType)key;/**< 判断是否包含Key */
@end

@interface NSMutableDictionary<KeyType, ObjectType> (Kit)
- (ObjectType)ay_objectForKey:(KeyType)key setDefault:(ObjectType (^)())defaultValue;/**< 获取object，如果没有，添加并返回defaultValue. */
@end

NS_ASSUME_NONNULL_END