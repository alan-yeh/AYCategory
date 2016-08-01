//
//  NSString_URL.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>

@interface NSString (AY_URL)
- (NSString *)ay_URLEncoding;/**< url encode */
- (NSString *)ay_URLDecoding;/**< url decode */
- (NSString *)ay_URLParamForKey:(NSString *)aKey;/**< 获取URL String里的参数的值 */
@end
