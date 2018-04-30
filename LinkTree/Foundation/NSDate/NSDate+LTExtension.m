//
//  NSDate+LTExtension.m
//  LinkTree
//
//  Created by 李沾 on 2018/4/18.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import "NSDate+LTExtension.h"

@implementation NSDate (LTExtension)

- (NSUInteger)lt_year{
    return [NSDate lt_yearWithDate:self];
}
- (NSUInteger)lt_month{
    return [NSDate lt_monthWithDate:self];
}
- (NSUInteger)lt_day{
    return [NSDate lt_dayWithDate:self];
}
- (NSUInteger)lt_hour{
    return [NSDate lt_hourWithDate:self];
}
- (NSUInteger)lt_minute{
    return [NSDate lt_minuteWithDate:self];
}
- (NSUInteger)lt_second{
    return [NSDate lt_secondWithDate:self];
}


+ (NSUInteger)lt_yearWithDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}
+ (NSUInteger)lt_monthWithDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}
+ (NSUInteger)lt_dayWithDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    return [dayComponents day];
}
+ (NSUInteger)lt_hourWithDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}
+ (NSUInteger)lt_minuteWithDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}
+ (NSUInteger)lt_secondWithDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}



@end
