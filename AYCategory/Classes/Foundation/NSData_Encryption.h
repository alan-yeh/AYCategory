//
//  NSData+Encryption.h
//  AYCategory
//
//  Created by RadioHead Ache on 2020/9/30.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (AY_Encyption)
- (NSData *)ay_DESEncryptDataWithKey:(NSString *)key;///< DES 加密
- (NSData *)ay_3DESEncryptDataWithKey:(NSString *)key;///< 3DES 加密
- (NSData *)ay_AESEncryptDataWithKey:(NSString *)key;///< AES 加密

- (NSData *)ay_DESDecryptDataWithKey:(NSString *)key;///< DES 解密
- (NSData *)ay_3DESDecryptDataWithKey:(NSString *)key;///< 3DES 解密
- (NSData *)ay_AESDecryptDataWithKey:(NSString *)key;///< AES 解密

@end

NS_ASSUME_NONNULL_END
