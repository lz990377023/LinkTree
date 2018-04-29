//
//  NSDate+LTExtension.h
//  LinkTree
//
//  Created by 李沾 on 2018/4/18.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LTExtension)

// 获取年、月、日、时、分、秒
- (NSUInteger)lt_year;
- (NSUInteger)lt_month;
- (NSUInteger)lt_day;
- (NSUInteger)lt_hour;
- (NSUInteger)lt_minute;
- (NSUInteger)lt_second;

// 传入日期对象来获取年、月、日、时、分、秒
+ (NSUInteger)lt_yearWithDate:(NSDate *)date;
+ (NSUInteger)lt_monthWithDate:(NSDate *)date;
+ (NSUInteger)lt_dayWithDate:(NSDate *)date;
+ (NSUInteger)lt_hourWithDate:(NSDate *)date;
+ (NSUInteger)lt_minuteWithDate:(NSDate *)date;
+ (NSUInteger)lt_secondWithDate:(NSDate *)date;


// 获取格式化为YYYY-MM-dd格式的日期字符串
- (NSString *)lt_formatYMD;
+ (NSString *)lt_formatYMD:(NSDate *)date;


// 获取一年中的总天数
- (NSUInteger)lt_daysInYear;

// 传入日期对象获取一年中的总天数
+ (NSUInteger)lt_daysInYearWithDate:(NSDate *)date;

// 判断是否是闰年
// @return YES为闰年，否则为平年
- (BOOL)lt_isLeapYear;

// 传入日期对象判断是否是闰年
// @return YES为闰年，否则为平年
+ (BOOL)lt_isLeapYearWithDate:(NSDate *)date;







@end
