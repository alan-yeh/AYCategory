//
//  AYJson.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSString (Json)
#pragma mark - JSON container convertors
- (nullable id)ay_jsonContainer;/**< 将json字符串转成NSArray或NSDictionary. */
- (nullable NSArray *)ay_jsonArray;/**< 将json字符串转成NSArray. 如果结果的类型不是NSArray, 将会抛出异常. */
- (nullable NSDictionary *)ay_jsonDictionary;/**< 将json字符串转成NSDictionary. 如果结果的类型不是NSDictionary, 将会抛出异常. */

#pragma mark - JSON mutable container convertors
- (nullable id)ay_jsonMutableContainer;/**< 将json字箱串转成NSMutableArray或NSMutableDictionary. */
- (nullable NSMutableArray *)ay_jsonMutableArray;/**< 将json字箱串转成NSMutableArray. 如果结果的类型不是NSMutableArray, 将会抛出异常. */
- (nullable NSMutableDictionary *)ay_jsonMutableDictionary;/**< 将json字箱串转成NSMutableDictionary. 如果结果的类型不是NSMutableDicationay, 将会抛出异常. */
@end


@interface NSDictionary (Json)
- (NSData *)ay_toJsonData;/**< 将NSDictionary转成Json格式的NSData. */
- (NSString *)ay_toJsonString;/**< 将NSDictionary转成Json格式的NSString. */
@end


@interface NSArray (Json)
- (NSData *)ay_toJsonData;/**< 将NSArray转成Json格式的NSData. */
- (NSString *)ay_toJsonString;/**< 将NSArray转成Json格式的NSString. */
@end


@interface NSData (Json)
#pragma mark - JSON container convertors
- (nullable id)ay_jsonContainer;/**< 使用UTF-8编码, 将NSData转成NSArray或NSDictionary. */
- (nullable NSArray *)ay_jsonArray;/**< 使用UTF-8编码, 将NSData转成NSArray. 如果结果的类型不是NSArray, 将会抛出异常. */
- (nullable NSDictionary *)ay_jsonDictionary;/**< 使用UTF-8编码, 将NSData转成NSDictionary. 如果结果的类型不是NSDictionary, 将会抛出异常. */

#pragma mark - JSON mutable container convertors
- (nullable id)ay_jsonMutableContainer;/**< 使用UTF-8编码, 将NSData转成NSMutableArray或NSMutableDictionary. */
- (nullable NSMutableArray *)ay_jsonMutableArray;/**< 使用UTF-8编码, 将NSData转成NSMutableArray. 如果结果的类型不是NSMutableArray, 将会抛出异常. */
- (nullable NSMutableDictionary *)ay_jsonMutableDictionary;/**< 使用UTF-8编码, 将NSData转成NSMutableDictionary. 如果结果的类型不是NSMutableDicationay, 将会抛出异常. */
@end

NS_ASSUME_NONNULL_END