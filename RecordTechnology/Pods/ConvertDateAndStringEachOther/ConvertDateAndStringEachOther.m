//
//  ConvertDateAndStringEachOther.m
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

#import "ConvertDateAndStringEachOther.h"

static NSMutableDictionary *_cachedDateFormatter = nil;

@implementation ConvertDateAndStringEachOther


+ (NSDate *)dateFromString:(NSString *)dateString formatString:(NSString *)formatStr
{
    if ( nil == dateString )
    {
        return nil;
    }
    
    NSString *format = nil;
    if ( nil == formatStr )
    {
        format = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    }
    else
    {
        format = [NSString stringWithFormat:@"%@", formatStr];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    
    return [ConvertDateAndStringEachOther localDateFromUTCDate:destDate];
}

+ (NSString *)stringFromDate:(NSDate *)date formatString:(NSString *)formatStr
{
    if ( nil == date )
    {
        return nil;
    }
    
    NSString *format = nil;
    if ( nil == formatStr )
    {
        format = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    }
    else
    {
        format = [NSString stringWithFormat:@"%@", formatStr];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

+ (NSDate *)UTCDateFromLocalDate:(NSDate *)date
{
    // time zone
    NSTimeZone *sourceTimeZone = [NSTimeZone localTimeZone];
    
    // interval
    NSTimeInterval interval = [sourceTimeZone secondsFromGMT];
    
    NSDate *destinationDateNow = [date dateByAddingTimeInterval:-interval];
    
    
    return destinationDateNow;
}

+ (NSDate *)localDateFromUTCDate:(NSDate *)date
{
    // time zone
    NSTimeZone *sourceTimeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSTimeZone *destinationTimeZone = [NSTimeZone localTimeZone];
    
    // offset
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
    
    // interval
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate *destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
    
    return destinationDateNow;
}


+(NSDateFormatter *)getDateFormatter:(NSString *)pattern {
    if (_cachedDateFormatter == nil)
        _cachedDateFormatter = [[NSMutableDictionary alloc] initWithCapacity:5];
    NSDateFormatter *formatter = [_cachedDateFormatter objectForKey:pattern];
    if (formatter != nil)
        return formatter;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:pattern];
    [_cachedDateFormatter setObject:formatter forKey:pattern];
    return formatter;
}

+ (NSString *)formatFileSizeByByte:(float)bytesSize{
    float fileSize = bytesSize/(1024.0*1024.0*1024.0);
    if (fileSize < 1.0){
        fileSize = fileSize * 1024.0;
        if (fileSize < 1.0){
            fileSize = fileSize * 1024.0;
            if (fileSize < 1.0)
                fileSize = 1.0;
            return [NSString stringWithFormat:@"%4.2f KB",fileSize];
        }else
            return [NSString stringWithFormat:@"%4.2f MB",fileSize];
    }else
        return [NSString stringWithFormat:@"%4.2f GB",fileSize];
}

+ (NSString *)formatTime:(NSTimeInterval)inter{
    NSTimeInterval val = inter/(60.0*60.0);
    int h,m,s;
    if (val < 1.0) {
        h = 0;
    }else {
        h = (int)val;
    }
    val = val * 60.0;
    if (val < 1.0) {
        m = 0;
    }else {
        m = ((int)val)%60;
    }
    val = val * 60;
    if (val < 1.0) {
        s = 0;
    }else {
        s = ((int)val)%60;
    }
    NSString *mstr = m < 10?[NSString stringWithFormat:@"0%d",m]:[NSString stringWithFormat:@"%d",m];
    NSString *sstr = s < 10?[NSString stringWithFormat:@"0%d",s]:[NSString stringWithFormat:@"%d",s];
    return [NSString stringWithFormat:@"%d:%@:%@",h,mstr,sstr];
}

+ (NSString *)formatDateWithAgo:(NSDate *)date{
    NSTimeInterval inter = -[date timeIntervalSinceNow];
    if (inter < 10.0f) {
        return @"Seconds ago";
    } else if (inter < 60.0f) {
        return @"Less than 1 min";
    }else {
        int mInter = (int)round(inter/60.0);
        if (mInter < 60.0) {
            if (mInter == 1) {
                return @"1 min ago";
            }else {
                return [NSString stringWithFormat:@"%d mins ago",mInter];
            }
        }else {
            int hInter = (int)round(inter/(60.0*60.0));
            if (hInter < 24) {
                if (hInter == 1) {
                    return @"1 hour ago";
                }else {
                    return [NSString stringWithFormat:@"%d hours ago",hInter];
                }
            }else {
                int dInter = (int)round(inter/(60.0*60.0*24.0));
                if (dInter < 7) {
                    if (dInter == 1) {
                        return @"1 day ago";
                    }else {
                        return [NSString stringWithFormat:@"%d days ago",dInter];
                    }
                }else {
                    int wInter = (int)round(inter/(60.0*60.0*24.0*7.0));
                    if (wInter < 4) {
                        if (wInter == 1) {
                            return @"1 week ago";
                        }else {
                            return [NSString stringWithFormat:@"%d weeks ago",wInter];
                        }
                    }else {
                        return [self formatDate:date style:HXFormatDateStyleWeek];
                    }
                }
            }
        }
    }
}

+ (NSString *)formatFBTime:(NSDate *)date {
    NSDateFormatter *format = [self getDateFormatter:@"h:mma"];
    return [format stringFromDate:date];
}

+ (NSString *)formatDateWithFBAgo:(NSDate *)date{
    NSTimeInterval inter = -[date timeIntervalSinceNow];
    if (inter < 10.0f) {
        return NSLocalizedString(@"Seconds ago",@"");
    } else if (inter < 60.0f) {
        return NSLocalizedString(@"Less than 1 min",@"");
    }else {
        int mInter = (int)round(inter/60.0);
        if (mInter < 60.0) {
            if (mInter == 1) {
                return NSLocalizedString(@"1 min ago",@"");
            }else {
                return [NSString stringWithFormat:NSLocalizedString(@"%d mins ago",@""),mInter];
            }
        }else {
            int hInter = (int)round(inter/(60.0*60.0));
            if (hInter < 24) {
                if (hInter == 1) {
                    return NSLocalizedString(@"1 hour ago",@"");
                }else {
                    return [NSString stringWithFormat:NSLocalizedString(@"%d hours ago",@""),hInter];
                }
            }else {
                int dInter = (int)round(inter/(60.0*60.0*24.0));
                if (dInter < 7) {
                    if (dInter == 1) {
                        return [[NSLocalizedString(@"Yesterday at", @"") stringByAppendingString:@" "] stringByAppendingString:[self formatFBTime:date]];
                    }else {
                        NSMutableString *str = [NSMutableString stringWithCapacity:20];
                        NSDateFormatter *format = [self getDateFormatter:@"EEEE"];
                        [str appendString:[format stringFromDate:date]];
                        [str appendString:@" "];
                        [str appendString:NSLocalizedString(@"at",@"")];
                        [str appendString:@" "];
                        [str appendString:[self formatFBTime:date]];
                        return str;
                    }
                }else {
                    int wInter = (int)round(inter/(60.0*60.0*24.0*7.0));
                    if (wInter < 4) {
                        if (wInter == 1) {
                            return  NSLocalizedString(@"1 week ago",@"");
                        }else {
                            return [NSString stringWithFormat:NSLocalizedString(@"%d weeks ago",@""),wInter];
                        }
                    }else {
                        return [self formatDate:date style:HXFormatDateStyleWeek];
                    }
                }
            }
        }
    }
}

+ (NSString *)formatDate:(NSDate *)date style:(HXFormatDateStyle)style{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    if (style == HXFormatDateStyleAgo) {
        return [self formatDateWithAgo:date];
    }else {
        NSString *formatString = nil;
        switch (style) {
            case HXFormatDateStyleNormal:
                formatString = @"MM/dd/yyyy 'at' HH:mm:ss aaa";
                break;
            case HXFormatDateStyleWeek:
                formatString = @"EEE MMM dd HH:mm a";
                break;
            case HXFormatDateStyleDay:
                formatString = @"yyyy-MM-dd";
                break;
            case HXFormatDateStylePointDay:
                formatString = @"yyy.MM.dd";
            default:
                break;
        }
        [format setDateFormat:formatString];
        return [format stringFromDate:date];
    }
}

+ (NSString *)formatDate:(NSDate *)date {
    return [self formatDate:date style:HXFormatDateStyleAgo];
}

+ (NSDate *)parseFBDateString:(NSString *)str {
    if (str == nil)
        return nil;
    NSDateFormatter *formatter = [self getDateFormatter:@"yyyy-MM-ddHH:mm:ssZZZZ"];
    return [formatter dateFromString:[str stringByReplacingOccurrencesOfString:@"T" withString:@""]];
}


+ (NSString *)timeFormat:(NSDate *)date style:(HXFormatTimeStyle)style{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:(style == HXFormatTimeStyle24)?@"HH:mm":@"hh:mm aaa"];
    return [format stringFromDate:date];
}


+ (NSString *)dateStringFromSicne1970:(NSInteger)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    return [dateFormatter stringFromDate:date];
}



@end
