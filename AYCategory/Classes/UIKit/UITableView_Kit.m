//
//  UITableView_Kit.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "UITableView_Kit.h"

@implementation UITableView (AYKit)
- (void)ay_registerClassForCell:(Class)cellClass{
    cellClass = cellClass ?: [UITableViewCell class];
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (UITableViewCell *)ay_dequeueReusableCellWithClass:(Class)cellClass{
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
}
@end
