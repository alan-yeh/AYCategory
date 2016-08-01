//
//  NSString_Kit.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXTERN NSString *NSStringWithFormat(NSString *format, ...) NS_FORMAT_FUNCTION(1,2);

@interface NSString (AY_Kit)
+ (NSString *)ay_randomStringWithLenght:(NSUInteger)lenght;/**< 随机字符串 */

- (BOOL)ay_containsString:(NSString *)aString;/**< 是否包含字符串 */
- (BOOL)ay_isEquals:(NSString *)anotherString;/**< 大小写敏感比较 */
- (BOOL)ay_isEqualsIgnoreCase:(NSString *)anotherString;/**< 大小写不敏感比较 */

- (NSInteger)ay_indexOfChar:(unichar)ch;/**< 定位字符第一次出现的位置 */
- (NSInteger)ay_indexOfChar:(unichar)ch fromIndex:(NSInteger)index;/**< 定位字符在${index}后第一次出现的位置 */
- (NSInteger)ay_indexOfString:(NSString *)str;/**< 定位字符串第一次出现的位置 */
- (NSInteger)ay_indexOfString:(NSString *)str fromIndex:(NSInteger)index;/**< 定位字符串在${index}后第一次出现的位置 */
- (NSInteger)ay_lastIndexOfChar:(unichar)ch;/**< 从后向前定位字符第一次出现的位置 */
- (NSInteger)ay_lastIndexOfChar:(unichar)ch fromIndex:(NSInteger)index;/**< 从后向前定位字符在${index}之前第一次出现的位置 */
- (NSInteger)ay_lastIndexOfString:(NSString *)str;/**< 从后向前定位字符串第一次出现的位置 */
- (NSInteger)ay_lastIndexOfString:(NSString *)str fromIndex:(NSInteger)index;/**< 从后向前定位字符串在${index}之前第一次出现的位置 */

- (NSString *)ay_substringFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;/**< 截字符串 */
- (NSString *)ay_substringFromIndex:(NSUInteger)from lenght:(NSUInteger)length;/**< 截取字符串, 从${from}开始, 截取${length}个字符 */
- (NSString *)ay_toLowerCase;/**< 转换成小写 */
- (NSString *)ay_toUpperCase;/**< 转换成大写 */
- (NSString *)ay_firstCharToLowerCase;/**< 第一个字符变大写 */
- (NSString *)ay_firstCharToUpperCase;/**< 第一个字符变小写 */
- (NSString *)ay_trim;/**< 移除前后的空格和回车 */
- (NSString *)ay_replaceAll:(NSString *)origin with:(NSString *)replacement;/**< 替换字符串 */
- (NSString *)ay_removePrefix:(NSString *)prefix;/**< 去掉前缀 */
- (NSString *)ay_removeSuffix:(NSString *)suffix;/**< 去掉后缀 */
- (NSArray<NSString *> *)ay_split:(NSString *)separator;/**< 根据分隔符分隔字符串 */

- (NSUInteger)ay_timesAppeard:(NSString *)aString;/**< 统计字符串出现的次数 */
@end

@interface NSMutableString (AY_Kit)
- (NSMutableString *)ay_appendString:(NSString *)aString;/**< 拼接字符串到后面 */
- (NSMutableString *)ay_appendFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);/**< 拼接字符串到后面 */
- (NSMutableString *)ay_subMutableStringFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;/**< 从${fromIndex}到${toIndex}截取字符串 */
- (NSMutableString *)ay_subMutableStringFromIndex:(NSUInteger)fromIndex;/**< 从${fromIndex}到尾截取字符串 */
- (NSMutableString *)ay_subMutableStringToIndex:(NSUInteger)toIndex;/**< 从头到${toIndex}截取字符串 */
@end
NS_ASSUME_NONNULL_END
