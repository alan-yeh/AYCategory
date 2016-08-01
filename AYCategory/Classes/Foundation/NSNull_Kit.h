//
//  NSNull_Kit.h
//  AYCategory
//
//  Created by PoiSon on 16/8/1.
//
//

#import <Foundation/Foundation.h>

/**
 *  Null safe
 *  如果启用Null save, 那么向[NSNull null]发送消息与向nil发送消息的效果相同, 即不会崩溃
 */
@interface NSNull (Safe)
/** 是否启用安全策略 */
+ (void)ay_setNullSafeEnabled:(BOOL)enabled;
@end
