//
//  NSString+Addition.h
//  BabyTime
//
//  Created by dong mike on 12-9-25.
//  Copyright (c) 2012年 dong mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additional)

+ (NSString *)GetUUID;
- (BOOL)startWith:(NSString *)str;
- (NSString *) hashStr;
+ (NSString *)md5:(NSString *)string;
+ (NSString*)encodeString:(NSString*)unencodedString;
+ (NSString *)decodeString:(NSString*)encodedString;
+ (BOOL)stringContainsEmoji:(NSString *)string;

/** 计算'/n'的个数 */
- (NSInteger)numberOfNewLine;

- (NSString *)urlencode;

@end