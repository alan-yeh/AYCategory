//
//  NSObject_Event.h
//  AYCategory
//
//  Created by PoiSon on 16/8/1.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AYEventPriority) {
    AYEventPriorityHigh = 1000, /**< 高优先级, 优先通知 */
    AYEventPriorityNormal = 5000, /**< 普通优先级 */
    AYEventPriorityLow = 10000 /**< 低优先级, 最后通知 */
};

@interface NSObject (AYEvent)
/**
 *  注册事件
 *
 *  @param name      事件名
 *  @param aSelector 回调方法, 第一个参数接收AYNotification对象
 *  @param sender    接收指定事件发送者（如果sender=nil，则接收全部事件）
 */
- (void)ay_registEvent:(NSString *)name selector:(SEL)aSelector sender:(nullable id)sender;
- (void)ay_registEvent:(NSString *)name selector:(SEL)aSelector sender:(nullable id)sender priority:(AYEventPriority)priority;
/**
 *  发送事件
 *
 *  @param name  事件名
 *  @param info  带参
 */
- (void)ay_dispatchEvent:(NSString *)name withUserInfo:(NSDictionary *)info;
@end


@interface AYEvent : NSObject
@property (nonatomic, weak) id sender;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSDictionary *userInfo;
@end
NS_ASSUME_NONNULL_END