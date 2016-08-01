//
//  UIViewController_Kit.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>

@interface UIViewController (Kit)
/** 类似于安卓的onActivityResult，自身调用即可。不需要判空 */
@property (nonatomic, copy) void (^ay_onControllerResult)(UIViewController *controller, NSUInteger resultCode, NSDictionary *data);
- (void)setAy_onControllerResult:(void (^)(UIViewController *controller, NSUInteger resultCode, NSDictionary *data))ay_onControllerResult;
@end
