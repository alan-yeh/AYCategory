//
//  NSObject_KVO.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>

#define AYKeyPath(...) \
metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__))(AYKeyPath1(__VA_ARGS__))(AYKeyPath2(__VA_ARGS__))

#define AYKeyPath1(PATH) \
@(((void)(NO && ((void)PATH, NO)), strchr(#PATH, '.') + 1))

#define AYKeyPath2(OBJ, PATH)\
@(((void)(NO && ((void)OBJ.PATH, NO)), #PATH))

@interface NSObject (AYKVO)
- (void)ay_addObserver:(void(^)(id obj, NSDictionary<NSString *, id> *change))callback forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options;
- (void)ay_clearObserversForKeyPath:(NSString *)keyPath;
@end