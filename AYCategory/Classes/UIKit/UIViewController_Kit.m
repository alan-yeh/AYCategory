//
//  UIViewController_Kit.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "UIViewController_Kit.h"
#import "NSObject_Runtime.h"

@implementation UIViewController (Kit)
AYAssociatedKey(AY_ON_CONTROLLER_RESULT_BLOCK);
- (void (^)(UIViewController *, NSUInteger, NSDictionary *))ay_onControllerResult{
    return [self ay_associatedObjectForKey:AY_ON_CONTROLLER_RESULT_BLOCK storeProlicy:AYStoreUsingCopyNonatomic setDefault:^id _Nonnull{
        return ^(UIViewController *viewController, NSUInteger code, NSDictionary *data){};//设置一个空的block，这样就不需要总是先判断了
    }];
}

- (void)setAy_onControllerResult:(void (^)(UIViewController *, NSUInteger, NSDictionary *))ay_onControllerResult{
    [self ay_setAssociatedObject:ay_onControllerResult forKey:AY_ON_CONTROLLER_RESULT_BLOCK usingProlicy:AYStoreUsingCopyNonatomic];
}
@end
