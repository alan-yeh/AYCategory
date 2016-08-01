//
//  NSSet_Kit.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSSet<ObjectType> (AYSearch)
- (NSSet<ObjectType> *)ay_setWithCondition:(BOOL (^)(ObjectType obj))condition;/**< 筛选符合条件的 */
- (NSSet<ObjectType> *)ay_removeWithCondition:(BOOL (^)(ObjectType obj))condition;/**< 删除符合条件的 */
- (NSSet<ObjectType> *)ay_setInSet:(NSSet<ObjectType> *)set;/**< 筛选两个Set中相同的元素 */
@end

@interface NSSet<ObjectType> (Kit)
- (NSString *)ay_join:(NSString *)separator; /**< 将元素用${separator}分隔并拼接成字符串. */
- (NSArray *)ay_toArray;/**< 转换成NSArray, 无序 */
- (NSMutableArray *)ay_toMutableArray;/**< 转换成NSMutableArray, 无序 */
@end
NS_ASSUME_NONNULL_END