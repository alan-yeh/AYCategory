//
//  UIView_Kit.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "UIView_Kit.h"
#import "convenientmacros.h"

@implementation UIView (Kit)
@dynamic ay_tag;
- (void)ay_clearSubviews{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}
AYAssociatedKeyAndNotes(AY_VIEW_TAG_OBJECT, "Store the tag value");
- (void)setAy_tag:(id)ay_tag useStorePolicy:(AYStorePolicy)plolicy{
    [self ay_setAssociatedObject:ay_tag forKey:AY_VIEW_TAG_OBJECT usingProlicy:plolicy];
}

- (id)ay_tag{
    return [self ay_associatedObjectForKey:AY_VIEW_TAG_OBJECT];
}

- (void)setAy_tag:(id)ay_tag{
    returnIf(ay_tag == nil);
    [self ay_setAssociatedObject:ay_tag forKey:AY_VIEW_TAG_OBJECT usingProlicy:AYStoreUsingRetainNonatomic];
}

- (UIViewController *)ay_viewController{
    UIResponder *next;
    while ((next = [self nextResponder])) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
    }
    return nil;
}

- (UIImage *)ay_snapshot{
    CGFloat oldAlpha = self.alpha;
    self.alpha = 1;
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.alpha = oldAlpha;
    return resultingImage;
}

- (void)ay_bringSelfToFront{
    [self.superview bringSubviewToFront:self];
}

- (NSArray<UIView *> *)ay_findSubviewsWithType:(Class)viewType{
    NSMutableArray<UIView *> *views = [NSMutableArray new];
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:viewType]) {
            [views addObject:view];
        }else{
            [views addObjectsFromArray:[view ay_findSubviewsWithType:viewType]];
        }
    }
    return views;
}

- (UIView *)ay_findFirstSubviewWithType:(Class)viewType{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:viewType]) {
            return view;
        }else{
            UIView *subView = [view ay_findFirstSubviewWithType:viewType];
            returnValIf(subView, subView);
        }
    }
    return nil;
}

+ (instancetype)ay_instanceWithNibName:(NSString *)nibNameOrNil bundel:(NSBundle *)nibBundleOrNil{
    if (!nibBundleOrNil) {
        nibBundleOrNil = [NSBundle mainBundle];
    }
    if (!nibNameOrNil.length) {
        nibNameOrNil = NSStringFromClass(self);
    }
    NSArray *nibView = [nibBundleOrNil loadNibNamed:nibNameOrNil owner:nil options:nil];
    if (nibView.count) {
        return nibView[0];
    }else{
        NSAssert(NO, @"Could not load NIB in bundle: '%@' with name '%@'", nibBundleOrNil, nibNameOrNil);
        return nil;
    }
}
@end