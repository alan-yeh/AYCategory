//
//  AYBlockInvocation.h
//  AYKit
//
//  Created by PoiSon on 16/2/19.
//  Copyright © 2016年 PoiSon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AYBlockInvocation : NSObject
+ (instancetype)invocationWithBlock:(id)block;
- (instancetype)initWithBlock:(id)block;

@property (nonatomic, readonly) NSMethodSignature *methodSignature;

- (void)getReutrnValue:(void *)retLoc;
- (void)setArgument:(void *)argLoc atIndex:(NSInteger)idx;

- (void)invoke;
@end
