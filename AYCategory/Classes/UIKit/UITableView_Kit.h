//
//  UITableView_Kit.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@interface UITableView (AYKit)
- (void)ay_registerClassForCell:(nullable Class)cellClass;/**< 注册重用cell */
- (nullable __kindof UITableViewCell *)ay_dequeueReusableCellWithClass:(nullable Class)cellClass;/**< 配合ay_registerClassForCell:使用 */
@end

NS_ASSUME_NONNULL_END