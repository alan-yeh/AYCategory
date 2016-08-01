//
//  NSDate_Kit.h
//  AYCategory
//
//  Created by PoiSon on 16/8/1.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSDateFormatter(CacheKit)
/* 由于创建Formatter是一个耗时操作, 因此将它缓存起来 */
+ (NSDateFormatter *)ay_formatterFromCache:(NSString *)format;
@end

@interface NSDate (Kit)
- (NSDate *)ay_dateByAddingDays:(NSInteger)days;
- (NSString *)ay_toString;/**< yyyy-MM-dd HH:mm:ss */
- (NSString *)ay_toString:(NSString *)format;

- (BOOL)ay_isLaterThan:(NSDate *)date;/**< 是否比${date}更早 */
- (BOOL)ay_isEarlierThan:(NSDate *)date;/**< 是否比${date}更晚 */

- (NSString *)ay_weakdayStr;/**< 返回当前日期 "星期X" */
@end

@interface NSString (AYDateExtensionMethods)
- (NSDate *)ay_dateValue:(NSString *)format;/**< 格式化日期字符串. */
@end
NS_ASSUME_NONNULL_END