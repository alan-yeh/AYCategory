//
//  AYBase64Encoding.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>

@interface NSString (AYBase64Encoding)
- (NSData *)ay_base64EncodedData;/**< base 64 编码 */
- (NSData *)ay_base64DecodedData;/**< base 64 解码 */
- (NSString *)ay_base64EncodedString;/**< base 64 编码后的字符串 */
- (NSString *)ay_base64DecodedString;/**< base 64 解码后的字符串 */
@end

@interface NSData (AYBase64Encoding)
- (NSString *)ay_base64EncodedString;/**< base 64 编码后的字符串 */
- (NSString *)ay_base64DecodedString;/**< base 64 解码后的字符串 */
- (NSData *)ay_base64EncodedData;/**< base 64 编码后的二进制 */
- (NSData *)ay_base64DecodedData;/**< base 64 解码后的二进制 */
@end
