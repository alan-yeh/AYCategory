//
//  UIView_Kit.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>
#import <AYCategory/NSObject_Runtime.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIView (Kit)
+ (instancetype)ay_instanceWithNibName:(nullable NSString *)nibNameOrNil bundel:(nullable NSBundle *)nibBundleOrNil;/**< 使用xib初始化. */

@property (nonatomic, nullable) id ay_tag; /**< 使用Strong策略保存Tag值 */
- (void)setPs_tag:(id)ay_tag useStorePolicy:(AYStorePolicy)plolicy; /**< 使用相关策略保存Tag值 */

- (void)ay_clearSubviews; /**< 清除所有子视图 */
- (__kindof UIViewController *)ay_viewController;/**< 查找包含此View的Controller. */
- (UIImage *)ay_snapshot;/**< 截图. */
- (void)ay_bringSelfToFront;/**< 使当前View在父View中前置. */
- (NSArray<__kindof UIView *> *)ay_findSubviewsWithType:(Class)viewType;/**< 递归寻找类型为viewType的subview. */
- (nullable __kindof UIView *)ay_findFirstSubviewWithType:(Class)viewType;/**< 递归导找类型为viewType的subview, 找到第一个时返回. */
@end
NS_ASSUME_NONNULL_END