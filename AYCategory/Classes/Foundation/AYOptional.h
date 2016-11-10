//
//  AYOptional.h
//  AYCategory
//
//  Created by Alan Yeh on 2016/11/10.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define AYOptional(type, obj) (obj ?: (typeof(obj))[type ay_optional])

@protocol AYOptional <NSObject>
+ (id)ay_optional;
@end

#pragma mark - Foundation
@interface NSArray (AYOptional) <AYOptional> @end
@interface NSDictionary (AYOptional) <AYOptional> @end
@interface NSSet (AYOptional) <AYOptional> @end
@interface NSOrderedSet (AYOptional) <AYOptional> @end
@interface NSHashTable (AYOptional) <AYOptional> @end
@interface NSMapTable (AYOptional) <AYOptional> @end

#pragma mark - UIKit
@interface UIView (AYOptional) <AYOptional> @end
