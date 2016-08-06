//
//  NSDate_Kit.m
//  AYCategory
//
//  Created by Alan Yeh on 16/8/1.
//
//

#import "NSDate_Kit.h"
#import "NSDictionary_Kit.h"

@implementation NSDateFormatter (CacheKit)
static NSMutableDictionary<NSString *, NSDateFormatter *> *ay_formatter_cache;

+ (NSDateFormatter *)ay_formatterFromCache:(NSString *)format{
    if (!ay_formatter_cache) {
        ay_formatter_cache = [NSMutableDictionary new];
    }
    return [ay_formatter_cache ay_objectForKey:format
                                    setDefault:^NSDateFormatter * _Nonnull{
                                        NSDateFormatter *newFormatter = [NSDateFormatter new];
                                        newFormatter.dateFormat = format;
                                        return newFormatter;
                                    }];
}

@end

@implementation NSDate (Kit)

- (NSDate *)ay_dateByAddingDays:(NSInteger)days{
    return [self dateByAddingTimeInterval:24 * 60 * 60 * days];
}

- (NSString *)ay_toString{
    return [self ay_toString:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)ay_toString:(NSString *)format{
    return [[NSDateFormatter ay_formatterFromCache:format] stringFromDate:self];
}

- (BOOL)ay_isEarlierThan:(NSDate *)date{
    return [self compare:date] == NSOrderedAscending;
}

- (BOOL)ay_isLaterThan:(NSDate *)date{
    return [self compare:date] == NSOrderedDescending;
}

- (NSString *)ay_weakdayStr{
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:self];
    switch (comps.weekday) {
        case 1:
            return @"星期天";
        case 2:
            return @"星期一";
        case 3:
            return @"星期二";
        case 4:
            return @"星期三";
        case 5:
            return @"星期四";
        case 6:
            return @"星期五";
    }
    return @"星期六";
}
@end

@implementation NSString(AYDateExtensionMethods)
- (NSDate *)ay_dateValue:(NSString *)format{
    return [[NSDateFormatter ay_formatterFromCache:format] dateFromString:self];
}
@end
