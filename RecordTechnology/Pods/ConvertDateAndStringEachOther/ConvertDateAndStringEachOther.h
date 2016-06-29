//
//  ConvertDateAndStringEachOther.h
//
//  Copyright (c) 2016年 Arthur Wang. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

typedef enum{
    HXFormatDateStyleNormal,
    HXFormatDateStyleAgo,			//default style
    HXFormatDateStyleWeek,
    HXFormatDateStyleDay,
    HXFormatDateStylePointDay,
}HXFormatDateStyle;

typedef enum{
    HXFormatTimeStyle24 = 0,
    HXFormatTimeStyle12
}HXFormatTimeStyle;

/*
 NSDate and NSString transform each other.
 UTC date and local date transform each other.
 */

@interface ConvertDateAndStringEachOther : NSObject

/**
 *  Transform NSString to NSDate
 *
 *  @param dateString The String like "2014-10-12T20:22:12Z"
 *  @param formatStr  The String like "yyyy-MM-dd'T'HH:mm:ss'Z'". If formatStr is nil, will
 *                    use "yyyy-MM-dd'T'HH:mm:ss'Z'"
 *
 *  @return Data type is NSDate
 */
+ (NSDate *)dateFromString:(NSString *)dateString formatString:(NSString *)formatStr;

/**
 *  Transform NSDate to NSString
 *
 *  @param date      Data type is NSDate
 *  @param formatStr The String like "yyyy-MM-dd'T'HH:mm:ss'Z'". If formatStr is nil, will
 *                   use "yyyy-MM-dd'T'HH:mm:ss'Z'"
 *
 *  @return Data type is NSString, like "2014-10-12T20:22:12Z"
 */
+ (NSString *)stringFromDate:(NSDate *)date formatString:(NSString *)formatStr;

/**
 *  Transform local date to UTC date.
 *
 *  @param date Data type is NSDate and the date is device's time.
 *
 *  @return UTC date
 */
+ (NSDate *)UTCDateFromLocalDate:(NSDate *)date;

/**
 *  Transform UTC date to local date.
 *
 *  @param date Data type is NSDate and UTC date.
 *
 *  @return Local date
 */
+ (NSDate *)localDateFromUTCDate:(NSDate *)date;



//////////////////////////////////////////////////////////////////////////////////////////////
//	4.2f GB/MB/KB
// eg: 15.32 MB
//////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)formatFileSizeByByte:(float)bytesSize;

//////////////////////////////////////////////////////////////////////////////////////////////
//	HH:MM:SS
// eg: 3:05:12
//////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)formatTime:(NSTimeInterval)inter;


//////////////////////////////////////////////////////////////////////////////////////////////
//	1 min ago / 3 weeks ago
// HXFormatDateStyleAgo is default style
//////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)formatDate:(NSDate *)date;
+ (NSString *)formatDate:(NSDate *)date style:(HXFormatDateStyle)style;

+ (NSString *)formatDateWithFBAgo:(NSDate *)date;
+ (NSDate *)parseFBDateString:(NSString *)str;


//////////////////////////////////////////////////////////////////////////////////////////////
//	23:30 or 11:30 PM
// HXFormatTimeStyle24 is default style
//////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)timeFormat:(NSDate *)date style:(HXFormatTimeStyle)style;

/**
 *  时间戳转@"yyyy-MM-dd"
 *
 *  @param time 时间戳
 *
 *  @return @"yyyy-MM-dd"字符串
 */
+ (NSString *)dateStringFromSicne1970:(NSInteger)time;



@end
