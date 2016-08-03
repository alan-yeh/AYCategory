//
//  NSObject_Event.m
//  AYCategory
//
//  Created by PoiSon on 16/8/1.
//
//

#import "NSObject_Event.h"
#import "NSDictionary_Kit.h"
#import "function.h"
#import "convenientmacros.h"
#import <objc/message.h>
#import <AYRuntime/AYDeallocNotifier.h>

@interface AYEventReceiver : NSObject
@property (nonatomic, weak) id receiver;
@property (nonatomic, weak) id sender;
@property (nonatomic) SEL selector;
+ (instancetype)receiverWithObj:(id)receiver sender:(id)sender selector:(SEL)aSelector;
@end

@interface AYEventRegister : NSObject
+ (void)registerObserver:(id)observer selector:(SEL)aSelector sender:(id)sender forEvent:(NSString *)event priority:(AYEventPriority)priority;
+ (void)dispatchEvent:(NSString *)event withSender:(id)sender userinfo:(NSDictionary *)info;
@end


@interface AYEvent()
+ (instancetype)eventForSender:(id)sender event:(NSString *)name userInfo:(NSDictionary *)userInfo;
@end

@implementation NSObject (AYEvent)
- (void)ay_registEvent:(NSString *)name selector:(SEL)aSelector sender:(id)sender{
    [AYEventRegister registerObserver:self selector:aSelector sender:sender forEvent:name priority:AYEventPriorityNormal];
}

- (void)ay_registEvent:(NSString *)name selector:(SEL)aSelector sender:(id)sender priority:(AYEventPriority)priority{
    [AYEventRegister registerObserver:self selector:aSelector sender:sender forEvent:name priority:priority];
}

- (void)ay_dispatchEvent:(NSString *)name withUserInfo:(NSDictionary *)info{
    [AYEventRegister dispatchEvent:name withSender:self userinfo:info];
}
@end

@implementation AYEventRegister
static NSMutableSet<AYEventReceiver *> *receiverHolder(){
    static NSMutableSet<AYEventReceiver *> *receivers;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        receivers = [NSMutableSet new];
    });
    return receivers;
}
static NSHashTable<AYEventReceiver *> *hightReceiver(NSString *event){
    static NSMutableDictionary <NSString *, NSHashTable<AYEventReceiver *> *> *receiver;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        receiver = [NSMutableDictionary new];
    });
    return [receiver ay_objectForKey:event setDefault:^NSHashTable<AYEventReceiver *> * _Nonnull{
        return [NSHashTable weakObjectsHashTable];
    }];
}
static NSHashTable<AYEventReceiver *> *normalReceiver(NSString *event){
    static NSMutableDictionary <NSString *, NSHashTable<AYEventReceiver *> *> *receiver;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        receiver = [NSMutableDictionary new];
    });
    return [receiver ay_objectForKey:event setDefault:^NSHashTable<AYEventReceiver *> * _Nonnull{
        return [NSHashTable weakObjectsHashTable];
    }];
}
static NSHashTable<AYEventReceiver *> *lowReceiver(NSString *event){
    static NSMutableDictionary <NSString *, NSHashTable<AYEventReceiver *> *> *receiver;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        receiver = [NSMutableDictionary new];
    });
    return [receiver ay_objectForKey:event setDefault:^NSHashTable<AYEventReceiver *> * _Nonnull{
        return [NSHashTable weakObjectsHashTable];
    }];
}

+ (void)registerObserver:(id)observer selector:(SEL)aSelector sender:(id)sender forEvent:(NSString *)event priority:(AYEventPriority)priority{
    AYEventReceiver *receiver = [AYEventReceiver receiverWithObj:observer sender:sender selector:aSelector];
    if (priority == AYEventPriorityNormal) {
        [normalReceiver(event) addObject:receiver];
    }else if (priority < AYEventPriorityNormal){
        [hightReceiver(event) addObject:receiver];
    }else{
        [lowReceiver(event) addObject:receiver];
    }
    [receiverHolder() addObject:receiver];
    
    [observer ay_notifyWhenDealloc:^{
        [receiverHolder() removeObject:receiver];
    }];
    
    if (sender) {
        [sender ay_notifyWhenDealloc:^{
            [receiverHolder() removeObject:receiver];
        }];
    }
}


+ (void)dispatchEvent:(NSString *)name withSender:(id)sender userinfo:(NSDictionary *)info{
    AYPrintf(@"📢📢AYEvent:<%@ %p> sent an event: %@\n", [sender class], sender, name);
    dispatchEvent(name, sender, info, hightReceiver(name));
    dispatchEvent(name, sender, info, normalReceiver(name));
    dispatchEvent(name, sender, info, lowReceiver(name));
}

static void dispatchEvent(NSString *event, id sender, NSDictionary *userinfo, NSHashTable<AYEventReceiver *> *receivers){
    dispatch_async(dispatch_get_main_queue(), ^{
        for (AYEventReceiver *receiver in receivers) {
            if (receiver.sender == nil || receiver.sender == sender) {
                AYEvent *psevent = [AYEvent eventForSender:sender event:event userInfo:userinfo];
                SuppressPerformSelectorLeakWarning([receiver.receiver performSelector:receiver.selector withObject:psevent]);
            }
        }
    });
}
@end



@implementation AYEvent
+ (instancetype)eventForSender:(id)sender event:(NSString *)name userInfo:(NSDictionary *)userInfo{
    AYEvent *notification = [AYEvent new];
    notification.sender = sender;
    notification.name = name;
    notification.userInfo = userInfo;
    return notification;
}
@end

@implementation AYEventReceiver
+ (instancetype)receiverWithObj:(id)receiver sender:(id)sender selector:(SEL)aSelector{
    AYEventReceiver *obj = [self new];
    obj.receiver = receiver;
    obj.sender = sender;
    obj.selector = aSelector;
    return obj;
}
@end