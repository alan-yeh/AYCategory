//
//  UIImage_Kit.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "UIImage_Kit.h"
#import "UIColor_Kit.h"
#import "UIView_Kit.h"
#import "aycategory_macros.h"

@implementation UIImage (Kit)
- (instancetype)ay_imageResized{
    CGFloat wCap = 3.5f;
    CGFloat hCap = 3.5f;
    return [self stretchableImageWithLeftCapWidth:wCap topCapHeight:hCap];
}

+ (instancetype)ay_imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (instancetype)ay_imageWithSize:(CGSize)size andColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (instancetype)ay_imageWithSize:(CGSize)size fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor byGradientType:(AYGradientType)gradientType{
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([toColor CGColor]);//Get 不需要释放 Create需要释放
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)@[(id)fromColor.CGColor,(id)toColor.CGColor], NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
        case 1:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, 0.0);
            break;
        case 2:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, size.height);
            break;
        case 3:
            start = CGPointMake(size.width, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)ay_imageNamed:(NSString *)name withTintColor:(UIColor *)color{
    static NSMapTable *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [NSMapTable strongToWeakObjectsMapTable];
    });
    NSString *imageKey = [NSString stringWithFormat:@"%@$%@", name, [color ay_hexString]];
    UIImage *image = [cache objectForKey:imageKey];
    returnValIf(image, image);
    //缓存
    image = [self ay_imageWithImage:[UIImage imageNamed:name] tintColor:color];
    [cache setObject:image forKey:imageKey];
    return image;
}

+ (instancetype)ay_imageWithImage:(UIImage *)image tintColor:(UIColor *)color{
    UIImageView *targetImageView = [[UIImageView alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    targetImageView.tintColor = color;
    return [targetImageView ay_snapshot];
}
@end
