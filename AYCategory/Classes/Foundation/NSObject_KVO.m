//
//  NSObject_KVO.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "NSObject_KVO.h"
#import "NSDictionary_Kit.h"
#import "NSObject_Runtime.h"

@interface AYKVOObserver : NSObject
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray *> *blocks;
@end

@implementation NSObject (AYKVO)
- (AYKVOObserver *)ay_observer{
    AYAssociatedKeyAndNotes(AY_KVO_OBSERVER_KEY, "保存观察者的实例");
    return [self ay_associatedObjectForKey:AY_KVO_OBSERVER_KEY
                              storeProlicy:AYStoreUsingRetainNonatomic
                                setDefault:^id _Nonnull{
                                    return [AYKVOObserver new];
                                }];
}

- (void)ay_addObserver:(void (^)(id _Nonnull, NSDictionary<NSString *,id> * _Nonnull))block forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options{
    AYKVOObserver *observer = [self ay_observer];
    [[observer.blocks ay_objectForKey:keyPath setDefault:^{return [NSMutableArray new];}] addObject:[block copy]];
    [self addObserver:observer forKeyPath:keyPath options:options context:nil];
}

- (void)ay_clearObserversForKeyPath:(NSString *)keyPath{
    AYKVOObserver *observer = [self ay_observer];
    [[observer.blocks objectForKey:keyPath] removeAllObjects];
    [self removeObserver:observer forKeyPath:keyPath];
}

@end

@implementation AYKVOObserver

- (NSMutableDictionary<NSString *,NSMutableArray *> *)blocks{
    return _blocks ?: (_blocks = [NSMutableDictionary new]);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSMutableArray *blocks = [[self blocks] objectForKey:keyPath];
    for (void(^block)(id, NSDictionary<NSString *, id> *) in blocks) {
        block(object, change);
    }
}
@end