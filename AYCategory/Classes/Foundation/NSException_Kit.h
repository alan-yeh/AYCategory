//
//  NSException_Kit.h
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import <Foundation/Foundation.h>

#define AYAssert(condition, desc, ...) \
   do { \
      __PRAGMA_PUSH_NO_EXTRA_ARG_WARNINGS \
      if (!(condition)) { \
         @throw [NSException ay_exceptionWhenExecuting: __func__ \
                                                inFile: [NSString stringWithUTF8String:__FILE__] ?: @"<Unknown File>" \
                                                atLine: __LINE__ \
                                           description: desc, ##__VA_ARGS__]; \
      } \
      __PRAGMA_POP_NO_EXTRA_ARG_WARNINGS \
   } while(0)

#define AYAssertFail(desc, ...) AYAssert(NO, desc, ##__VA_ARGS__)
#define AYAssertParameter(condition) AYAssert((condition), @"Invalid parameter not satisfying: %@", @#condition)

NS_ASSUME_NONNULL_BEGIN
@interface NSException (Kit)
+ (instancetype)ay_exceptionWhenExecuting:(const char *)function inFile:(NSString *)fileName atLine:(NSInteger)line description:(nullable NSString *)format, ...;
@end
NS_ASSUME_NONNULL_END
