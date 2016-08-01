//
//  UIColor_Kit.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "UIColor_Kit.h"
#import "NSString_Kit.h"
#import "convenientmacros.h"

@implementation UIColor (Kit)
+(UIColor *)ay_randomColor{
    CGFloat red = arc4random() % 256 /255.0;
    CGFloat blue = arc4random() % 256 /255.0;
    CGFloat green = arc4random() % 256 /255.0;
    return [UIColor colorWithRed:red green:blue blue:green alpha:1];
}

+ (UIColor *)ay_colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha{
    return [self colorWithRed:red/255.0f green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+ (UIColor *)ay_colorWithHex:(int64_t)hexValue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((hexValue & 0xFF0000) >> 16)/ 255.0
                           green:((hexValue & 0xFF00) >> 8)/ 255.0
                            blue:(hexValue & 0xFF)/ 255.0
                           alpha:alpha];
}

+ (UIColor *)ay_colorWithHex:(int64_t)hexValue{
    return [UIColor colorWithRed:((hexValue & 0xFF0000) >> 16)/255.0f
                           green:((hexValue & 0xFF00) >> 8)/255.0f
                            blue:(hexValue & 0xFF)/255.0f
                           alpha:((hexValue & 0xFF000000) >> 24)/255.0f];
}

- (UIColor *)ay_setAlpha:(CGFloat)alpha{
    CGFloat red, green, blue;
    [self ay_getRed:&red green:&green blue:&blue alpha:nil];
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (UIColor *)ay_reverseColor{
    CGFloat red, green, blue, alpha;
    [self ay_getRed:&red green:&green blue:&blue alpha:&alpha];
    return [UIColor colorWithRed:1 - red green:1 - green blue:1 - blue alpha:alpha];
}

- (int64_t)ay_hexValue{
    CGFloat red, green, blue, alpha;
    [self ay_getRed:&red green:&green blue:&blue alpha:&alpha];
    
    int64_t iRed, iGreen, iBlue, iAlpha;
    iAlpha = (int64_t)(alpha * 255);
    iRed = (int64_t)(red * 255);
    iGreen = (int64_t)(green * 255);
    iBlue = (int64_t)(blue * 255);
    
    int64_t result = (iAlpha << 24) + (iRed << 16) + (iGreen << 8) + iBlue;
    return result;
}

- (NSString *)ay_hexString{
    CGFloat red, green, blue;
    [self getRed:&red green:&green blue:&blue alpha:nil];
    
    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)(red * 255),
            (int)(green * 255),
            (int)(blue * 255)];
}

- (void)ay_getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha{
    CGFloat fRed, fGreen, fBlue, fAlpha;
    
    CGColorRef colorRef = [self CGColor];
    const CGFloat *components = CGColorGetComponents(colorRef);
    
    size_t count = CGColorGetNumberOfComponents(colorRef);
    if (count == 4) {
        fRed = components[0];
        fGreen = components[1];
        fBlue = components[2];
        fAlpha = components[3];
    }else if (count == 2){
        fRed = components[0];
        fGreen = components[0];
        fBlue = components[0];
        fAlpha = components[1];
    }else{
        fRed = 0;
        fGreen = 0;
        fBlue = 0;
        fAlpha = 0;
    }
    doIf(red != NULL, *red = fRed);
    doIf(green != NULL, *green = fGreen);
    doIf(blue != NULL, *blue = fBlue);
    doIf(alpha != NULL, *alpha = fAlpha);
}
@end

@implementation UIColor (AYColorFormString)
+ (UIColor *)ay_colorFromString:(NSString *)colorString{
    NSParameterAssert(colorString != nil && colorString.length > 0);
    
    if ([colorString hasPrefix:@"#"]) {
        //处理类似#FFFFFF的色值
        return [self _ay_colorFromHexString:[colorString substringFromIndex:1]];
    }else if ([colorString hasPrefix:@"0X"] || [colorString hasPrefix:@"0x"]){
        //处理类似OXFFFFFF的色值
        return [self _ay_colorFromHexString:[colorString substringFromIndex:2]];
    }else{
        NSArray<NSString *> *rgbs = [colorString componentsSeparatedByString:@","];
        switch (rgbs.count) {
            case 1:{
                float white = [rgbs[0] floatValue];
                return [UIColor colorWithWhite:white alpha:1];
                break;
            }
            case 2:{
                float white = [rgbs[0] floatValue];
                float alpha = [rgbs[1] floatValue];
                return [UIColor colorWithWhite:white alpha:alpha];
                break;
            }
            case 3:{
                float red = [rgbs[0] floatValue];
                float green = [rgbs[1] floatValue];
                float blue = [rgbs[2] floatValue];
                return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
                break;
            }
            case 4:{
                float red = [rgbs[0] floatValue];
                float green = [rgbs[1] floatValue];
                float blue = [rgbs[2] floatValue];
                float alpha = [rgbs[3] floatValue];
                return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
                break;
            }
            default:
                break;
        }
    }
    return nil;
}

//如果是6位的, 则不含有alpha, 8位含有alpha
+ (UIColor *)_ay_colorFromHexString:(NSString *)hexString{
    if (hexString.length != 6 && hexString.length != 8) {
        return [UIColor blackColor];
    }
    NSString *rString = [hexString ay_substringFromIndex:0 lenght:2];
    NSString *gString = [hexString ay_substringFromIndex:2 lenght:2];
    NSString *bString = [hexString ay_substringFromIndex:4 lenght:2];
    NSString *sString = @"FF";
    if (hexString.length == 8) {
        sString = [hexString ay_substringFromIndex:6 lenght:2];
    }
    unsigned int r, g, b, s;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    [[NSScanner scannerWithString:sString] scanHexInt:&s];
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b/255.0f alpha:s/255.0f];
}
@end