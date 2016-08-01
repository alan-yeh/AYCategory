//
//  convenientmacros.h
//  Pods
//
//  Created by PoiSon on 16/8/1.
//
//

#ifndef AY_CONVENIENT_MACROS_H
#define AY_CONVENIENT_MACROS_H

#define returnValIf(condition, val) if (!!(condition)){ return val;}
#define returnIf(condition)         if (!!(condition)){ return;    }
#define breakIf(condition)          if (!!(condition)){ break;     }
#define continueIf(condition)       if (!!(condition)){ continue;  }


#define doIf(condition, action) \
   do {                         \
      if(!!(condition)){        \
         action;                \
      }                         \
   } while(0)

//消除[NSObject performSelector:]引起的警告
#define SuppressPerformSelectorLeakWarning(action)                        \
   do {                                                                   \
      _Pragma("clang diagnostic push")                                    \
      _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
      action;                                                             \
      _Pragma("clang diagnostic pop")                                     \
   } while (0)

/**
 *  不定参数取值
 *
 *  示例:
 *  - (void)log:(NSString *)format, ...{
 *     va_args(format);
 *     NSString *info = [[NSString alloc] initWithFormat:format arguments:format_args];
 *     NSLog(info, nil);
 *   }
 */
#define va_args(arg_start)                  \
   va_list arg_start##_##args;              \
   va_start(arg_start##_##args, arg_start); \
   va_end(arg_start##_##args);



#endif

/**
 *  强弱引用转换，用于解决代码块（block）与强引用对象之间的循环引用问题
 *  调用方式: `weak`实现弱引用转换，`strong(object)`实现强引用转换
 *
 *  示例：
 *  weak(object)
 *  [obj block:^{
 *      strong(object)
 *      object = something;
 *  }];
 */
#ifndef	weak
   #define weak(object) __weak __typeof__(object) weak##_##object = object;
#endif
#ifndef	strong
   #define strong(object) __typeof__(object) object = weak##_##object;
#endif