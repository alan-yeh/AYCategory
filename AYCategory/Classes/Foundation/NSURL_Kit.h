//
//  NSURL_Kit.h
//  AYCategory
//
//  Created by Alan Yeh on 2017/10/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSURL (Kit)
- (nullable NSString *)ay_decodedString; /**< absoluteString再decode，输出未转码的http字符串 */

+ (nullable NSURL *)ay_URLWithString:(NSString *)URLString; /**< 先decode一下，再encode一下，可以处理URL里面含有中文的地址 */
+ (nullable NSURL *)ay_URLWithString:(NSString *)URLString relativeToURL:(nullable NSURL *)baseURL; /**< 先decode一下，再encode一下，可以处理URL里面含有中文的地址 */
@end
NS_ASSUME_NONNULL_END
