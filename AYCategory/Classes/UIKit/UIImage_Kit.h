//
//  UIImage_Kit.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>

typedef enum  {
    AYGradientTopToBottom = 0,/**< 从上到小 */
    AYGradientLeftToRight = 1,/**< 从左到右 */
    AYGradientUpleftTolowRight = 2,/**< 左上到右下 */
    AYGradientUprightTolowLeft = 3/**< 右上到左下 */
}AYGradientType;

NS_ASSUME_NONNULL_BEGIN
@interface UIImage (Kit)
- (instancetype)ay_imageResized;/**< 将图片拉申后返回(上下左右3.5f) */
+ (instancetype)ay_imageWithColor:(UIColor *)color;/**< 返回1*1像素的色块 */
+ (instancetype)ay_imageWithSize:(CGSize)size andColor:(UIColor *)color;/**< 返回指定像素大小的色块 */
+ (instancetype)ay_imageNamed:(NSString *)name withTintColor:(UIColor *)color;/**< 将图片中的不透明部份转换成目标颜色(缓存) */
+ (instancetype)ay_imageWithImage:(UIImage *)image tintColor:(UIColor *)color;/**< 将图片中的不透明部份转换成目标颜色(不缓存) */
/**
 *  绘制渐变色图片
 *
 *  @param size         图片大小
 *  @param fromColor    渐变开始颜色
 *  @param toColor      渐变结束颜色
 *  @param gradientType 渐变方式
 */
+ (instancetype)ay_imageWithSize:(CGSize)size fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor byGradientType:(AYGradientType)gradientType;
@end
NS_ASSUME_NONNULL_END
