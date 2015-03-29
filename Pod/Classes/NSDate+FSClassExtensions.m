//
// NSDate+FSClassExtensions.m
//
// The MIT License (MIT)
// 
// Copyright (c) 2013 FocalShift
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#import "NSDate+FSClassExtensions.h"

NSString * const ISODateFormat = @"yyyy-MM-dd";
NSString * const ISOTimeFormat = @"HH:mm:ss.SSSSSS";

@implementation NSDate (FSClassExtensions)

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    return [NSDate dateWithYear:year month:month day:day hour:NSDateComponentUndefined minute:NSDateComponentUndefined second:NSDateComponentUndefined];
}

+ (NSDate *)dateWithHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    return [NSDate dateWithYear:NSDateComponentUndefined month:NSDateComponentUndefined day:NSDateComponentUndefined hour:hour minute:minute second:second];
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    return [NSDate dateWithYear:year month:month day:day hour:hour minute:minute second:second timeZone:tz];
}

+ (NSDate *)gmtDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    return [NSDate gmtDateWithYear:year month:month day:day hour:NSDateComponentUndefined minute:NSDateComponentUndefined second:NSDateComponentUndefined];
}

+ (NSDate *)gmtDateWithHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    return [NSDate gmtDateWithYear:NSDateComponentUndefined month:NSDateComponentUndefined day:NSDateComponentUndefined hour:hour minute:minute second:second];
}

+ (NSDate *)gmtDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    NSTimeZone *tz = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    return [NSDate dateWithYear:year month:month day:day hour:hour minute:minute second:second timeZone:tz];
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second timeZone:(NSTimeZone *)tz {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:tz];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:second];
    return [calendar dateFromComponents:components];
}

- (NSString *)ISODate
{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [f setDateFormat:ISODateFormat];
    return [f stringFromDate:self];
}

- (NSString *)ISOTime
{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [f setDateFormat:ISOTimeFormat];
    return [f stringFromDate:self];
}

@end

