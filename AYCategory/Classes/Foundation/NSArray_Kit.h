//
//  NSArray_Kit.h
//  AYCategory
//
//  Created by PoiSon on 16/8/1.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSArray<ObjectType> (AYSearch)
- (NSArray<ObjectType> *)ay_arrayWithCondition:(BOOL (^)(ObjectType obj))condition;/**< 筛选符合条件的 */
- (NSArray<ObjectType> *)ay_removeWithCondition:(BOOL (^)(ObjectType obj))condition;/**< 删除符合条件的 */
- (NSArray<ObjectType> *)ay_arrayInArray:(NSArray<ObjectType> *)array;/**< 筛选两个数组中相同的元素 */
@end

@interface NSArray<ObjectType>(Kit)
- (NSArray<ObjectType> *)ay_objectsBeforIndex:(NSUInteger)index;/**< 取前几个元素. */
- (NSArray<ObjectType> *)ay_objectsAfterIndex:(NSUInteger)index;/**< 取后几个元素. */
- (NSArray<ObjectType> *)ay_objectsInRange:(NSRange)range;/**< 取出范围内的元素. */

- (instancetype)reverse;/**< 元素倒序 */

- (NSString *)ay_join:(NSString *)separator;/**< 将元素拼接成字符串，使用${separator}分割 */

- (NSSet *)ay_toSet;/**< 转换成NSSet */
- (NSMutableSet *)ay_toMutableSet;/**< 转换成NSMutableSet */

- (instancetype)ay_initWithEnumerator:(NSEnumerator *)enumerator;/**< 使用Enumerator初始化 */
+ (instancetype)ay_arrayWithEnumerator:(NSEnumerator *)enumerator;/**< 使用Enumerator初始化 */
@end

@interface NSMutableArray<ObjectType> (Kit)
- (void)ay_removeObjectsFormArray:(NSArray<ObjectType> *)array;/**< 移除array中的元素. */
- (void)ay_replaceObject:(ObjectType)obj withObjec:(ObjectType)anotherObj;/**< 替换元素. */
- (void)ay_moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;/**< 将fromIndex上的元素移至toIndex. */

- (void)ay_insertObjectAtFirst:(ObjectType)obj;/**< 向头部插入一个元素. */
- (void)ay_insertObjectsAtFirst:(NSArray<ObjectType> *)array;/**< 向头部插入一个数组. */

- (nullable ObjectType)ay_removeFirstObject;/**< 移除第一个元素，并返回它. */
- (NSArray<ObjectType> *)ay_removeFirstObjects:(NSUInteger)count;/**< 移除前几个元素，并返回它们. */

- (void)ay_addObject:(ObjectType)obj;/**< 添加一个元素(尾部). */
- (void)ay_addObjects:(NSArray<ObjectType> *)array;/**< 添加一个数组(尾部). */
- (nullable ObjectType)ay_removeLastObject;/**< 移除最后一个元素. */
- (NSArray<ObjectType> *)ay_removeLastObjects:(NSUInteger)count;/**< 移除最后几个元素. */

- (void)ay_addObjectsFormEnumerator:(NSEnumerator *)enumerator;/**< 添加Enumerator下的元素 */
@end
NS_ASSUME_NONNULL_END
