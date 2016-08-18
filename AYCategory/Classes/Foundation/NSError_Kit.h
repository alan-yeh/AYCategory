//
//  NSError_Kit.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>

#define AYAssertError(condition, desc, ...) \
   do { \
      __PRAGMA_PUSH_NO_EXTRA_ARG_WARNINGS \
      if (!(condition)) { \
         @throw [NSError ay_errorWhenExecuting: __func__ \
                                        inFile: [NSString stringWithUTF8String:__FILE__] ?: @"<Unknown File>" \
                                        atLine: __LINE__ \
                                   description: desc, ##__VA_ARGS__]; \
      } \
      __PRAGMA_POP_NO_EXTRA_ARG_WARNINGS \
   } while(0)

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSError *NSErrorWithLocalizedDescription(NSString *description);

@interface NSError (AYKit)
+ (instancetype)ay_errorWithLocalizedDescription:(NSString *)description;
+ (instancetype)ay_errorWhenExecuting:(const char *)function inFile:(NSString *)fileName atLine:(NSInteger)line description:(nullable NSString *)format, ...;
@end
NS_ASSUME_NONNULL_END