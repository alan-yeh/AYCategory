//
//  UIControl_Kit.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>

typedef void (^AYEventHandler)(id sender, UIControlEvents events, UIEvent *event);

@interface UIControl (AYKit)

/** 移除事件处理器 */
- (void)ay_clearHandlersForEvents:(UIControlEvents)controlEvents;/**< Remove all handler for event.*/

/**
 *  与addTarget:action:forControlEvents:的效果一致
 */
- (void)ay_addHandler:(AYEventHandler)handler forControlEvents:(UIControlEvents)controlEvents;

- (void(^)(UIControlEvents event, id handler))ay_on;/**< 添加处理器，handler如果有参数，第一个为sender，第二个为UIEvent */
@end