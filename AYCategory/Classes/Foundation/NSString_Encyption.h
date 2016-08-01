//
//  NSString_Encyption.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>

@interface NSString (AY_Encyption)
- (NSString *)ay_MD5Encrypt;/**< MD5 */

- (NSString *)ay_3DESEncryptWithKey:(NSString *)aKey;/**< 3DES加密 */
- (NSString *)ay_3DESDecryptWithKey:(NSString *)aKey;/**< 3DES解密 */
@end