//
//  UIColor_Kit.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define RgbHex2UIColor(r, g, b)                 [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RgbHex2UIColorWithAlpha(r, g, b, a)     [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

NS_ASSUME_NONNULL_BEGIN
@interface UIColor (Kit)
+ (UIColor *)ay_randomColor;/**< 随机颜色 */

+ (UIColor *)ay_colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;/**< 直接输入int，该方法会执行red/255.0f */

+ (UIColor *)ay_colorWithHex:(int64_t)hexValue alpha:(CGFloat)alpha;/**< 0xFFFFFF 6位16进制颜色 + 透明度 */
+ (UIColor *)ay_colorWithHex:(int64_t)hexValue;/**< 0xFFFFFFFF 8位16进制，32位2进制。使用64位int是防止以后扩展 */
- (int64_t)ay_hexValue;// 0xFFFFFFFF color的二进制，ARGB，32位
- (NSString *)ay_hexString;//返回类似 @"0xFFFFFFFF" 这样的字符串

- (UIColor *)ay_setAlpha:(CGFloat)alpha;/**< 不改变颜色值，改变透明度 */
- (UIColor *)ay_reverseColor;/**< 反色 */
- (void)ay_getRed:(nullable CGFloat *)red green:(nullable CGFloat *)green blue:(nullable CGFloat *)blue alpha:(nullable CGFloat *)alpha;/**< 将颜色分解成ARGB */
@end

@interface UIColor (AYColorFormString)
/**
 *  将符合规则的字符串解析成UIColor
 *  @"0.1"               -->   [UIColor colorWithWhite:0.1 alpha:1];
 *  @"0.1, 0.2"          -->   [UIColor colorWithWhite:0.1 alpha:0.2];
 *  @"106, 100, 20"      -->   [UIColor colorWithRed:106/255.0f green:100/255.0f blue:20/255.0f alpha:1];
 *  @"100, 20, 60, 0.7"  -->   [UIColor colorWithRed:100/255.0f green:20/255.0f blue:60/255.0f alpha:0.7];
 *  @"#FFFFFF"           -->   [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];
 *  @"#FFFFFFFF"         -->   [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:255/255.0f];
 */
+ (UIColor *)ay_colorFromString:(NSString *)colorString;
@end
NS_ASSUME_NONNULL_END