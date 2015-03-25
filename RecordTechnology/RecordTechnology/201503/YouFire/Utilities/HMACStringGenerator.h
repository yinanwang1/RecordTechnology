//
//  HMACStringGenerator.h
//  HMACTest
//
//  Created by ArthurWang on 1/22/15.
//  Copyright (c) 2015 Engage Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMACStringGenerator : NSObject

+ (NSString *)generateAuthValueWithMethod:(NSString *)method
                              requestBody:(NSString *)requestBody
                                     date:(NSString *)date
                                 username:(NSString *)username
                                     path:(NSString *)path
                             preSharedKey:(NSString *)preSharedKey;

+ (NSString *)currentDateString;

@end

@interface NSString (MD5)

- (NSString *)MD5;
+ (NSString *)base64StringFromData:(NSData *)data;

@end
