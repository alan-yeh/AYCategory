//
//  NSData_Kit.h
//  AYCategory
//
//  Created by PoiSon on 16/8/1.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSData (Kit)
- (NSData *)ay_dataWithTargetEncodingFromUTF8:(NSStringEncoding)targetEncoding;/**< 将UTF8编码的NSData转成目标编码 */
- (NSData *)ay_dataWithUTF8FromEncoding:(NSStringEncoding)fromEncoding;/**< 将目标编码的NSData转成UTF8编码 */
@end


//@interface NSData (AYGZip)
///** gzip压缩 */
//- (NSData *)ay_gzipCompression;
///** gzip解压 */
//- (NSData *)ay_gzipDecompression;
//@end

NS_ASSUME_NONNULL_END
