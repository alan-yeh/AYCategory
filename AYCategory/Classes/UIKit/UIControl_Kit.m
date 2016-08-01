//
//  UIControl_Kit.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "UIControl_Kit.h"
#import "NSString_Kit.h"
#import "NSObject_Runtime.h"
#import "AYBlockInvocation.h"
#import <objc/runtime.h>
#import <objc/message.h>

#define AY_EVENT_SEP @"__ay_event__"

@implementation UIControl (AYKit)
- (void (^)(UIControlEvents, id))ay_on{
    return ^(UIControlEvents event, id handler){
        [self ay_addHandler:^(__strong id sender, UIControlEvents events, UIEvent *event) {
            AYBlockInvocation *invocation = [AYBlockInvocation invocationWithBlock:handler];
            
            NSUInteger argCount = invocation.methodSignature.numberOfArguments;
            
            if (argCount > 1) {
                [invocation setArgument:&sender atIndex:1];
            }
            if (argCount > 2) {
                [invocation setArgument:&event atIndex:2];
            }
            
            [invocation invoke];
        } forEvent:event];
    };
}

- (void (^)(UIControlEvents))off{
    return ^(UIControlEvents events){
        [self ay_clearHandlersForEvents:events];
    };
}

/**
 *  保存Handlers的实例
 */
- (NSMutableDictionary<NSNumber/*UIControlEvents*/*, NSMutableArray<AYEventHandler> *> *)_ay_operations{
    AYAssociatedKeyAndNotes(AY_OPERATION_KEY, "保存Handlers的实例");
    return [self ay_associatedObjectForKey:AY_OPERATION_KEY storeProlicy:AYStoreUsingRetainNonatomic setDefault:^id{
        return [NSMutableDictionary new];
    }];
}

/**
 *  保存Handler
 */
- (void)ay_addHandler:(AYEventHandler)handler forEvent:(UIControlEvents)event{
    NSMutableArray<AYEventHandler> *handlers = [self._ay_operations objectForKey:@(event)];
    if (!handlers) {
        handlers = [NSMutableArray new];
    }
    [handlers addObject:[handler copy]];
    [self._ay_operations setObject:handlers forKey:@(event)];
}

/**
 *  删除某事件的所有Handler
 */
- (void)ay_clearHandlersForEvents:(UIControlEvents)controlEvents{
    NSArray<NSNumber *> *events = self.class._ay_events;
    for (NSInteger i = 0; i < events.count; i ++) {
        UIControlEvents obj = [events[i] integerValue];
        if ((obj & controlEvents) == obj) {
            [[self _ay_operations] removeObjectForKey:@(obj)];
            [self removeTarget:self action:NSSelectorFromString(NSStringWithFormat(@"%@%@sender:forEvent:", @(obj), AY_EVENT_SEP)) forControlEvents:obj];
        }
    }
}

/**
 *  添加某事件的处理方法
 */
- (void)ay_addHandler:(AYEventHandler)handler forControlEvents:(UIControlEvents)controlEvents{
    NSArray<NSNumber *> *events = self.class._ay_events;
    for (NSUInteger i = 0; i < events.count; i ++) {
        UIControlEvents obj = [events[i] integerValue];
        if ((obj & controlEvents) == obj) {
            [self addTarget:self action:NSSelectorFromString(NSStringWithFormat(@"%@%@sender:forEvent:", @(obj), AY_EVENT_SEP)) forControlEvents:obj];
            [self ay_addHandler:handler forEvent:obj];
        }
    }
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if ([NSStringFromSelector(sel) ay_containsString:AY_EVENT_SEP]) {
        return class_addMethod(self, sel, (IMP)_objc_msgForward, "v@:@@");
    }
    return [super resolveInstanceMethod:sel];
}

/**
 *  处理事件
 */
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    if ([self _ay_is_event_method:anInvocation.selector]) {
        UIControlEvents events = [self _ay_getEventFromSelector:anInvocation.selector];
        __unsafe_unretained UIEvent *event;
        [anInvocation getArgument:&event atIndex:3];
        
        NSArray *handlers = [self._ay_operations objectForKey:@(events)];
        for (AYEventHandler handler in handlers) {
            handler(self, events, event);
        }
    }else{
        [super forwardInvocation:anInvocation];
    }
}

/**
 *  判断某个selector是否是事件处理函数
 */
- (BOOL)_ay_is_event_method:(SEL)aSelector{
    return [[self.class _ay_events] containsObject:@([self _ay_getEventFromSelector:aSelector])];
}

/**
 *  提取selector中的事件名称
 */
- (UIControlEvents)_ay_getEventFromSelector:(SEL)aSelector{
    NSString *selectorStr = NSStringFromSelector(aSelector);
    if ([selectorStr containsString:AY_EVENT_SEP]) {
        return [[[selectorStr componentsSeparatedByString:AY_EVENT_SEP] objectAtIndex:0] integerValue];
    }
    return 0;
}

/**
 *  事件列表
 */
+ (NSArray<NSNumber *> *)_ay_events{
    static NSArray<NSNumber *> *array;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        array = @[@(UIControlEventTouchDown),
                  @(UIControlEventTouchDownRepeat),
                  @(UIControlEventTouchDragInside),
                  @(UIControlEventTouchDragOutside),
                  @(UIControlEventTouchDragEnter),
                  @(UIControlEventTouchDragExit),
                  @(UIControlEventTouchUpInside),
                  @(UIControlEventTouchUpOutside),
                  @(UIControlEventTouchCancel),
                  @(UIControlEventValueChanged),
                  @(UIControlEventEditingDidBegin),
                  @(UIControlEventEditingChanged),
                  @(UIControlEventEditingDidEnd),
                  @(UIControlEventEditingDidEndOnExit),
                  @(UIControlEventAllTouchEvents),
                  @(UIControlEventAllEditingEvents),
                  @(UIControlEventApplicationReserved),
                  @(UIControlEventSystemReserved),
                  @(UIControlEventAllEvents)
                  ];
    });
    return array;
}
@end
