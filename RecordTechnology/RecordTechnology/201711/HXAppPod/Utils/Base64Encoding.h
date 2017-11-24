//
//  Base64Encoding.h
//  store
//
//  Created by Arthur Wang on 14-10-13.
//  Copyright (c) 2014年 Arthur Wang All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64Encoding : NSObject

+(NSString *)base64StringFromData:(NSData *)data;
+ (NSString*)base64forData:(NSData*)theData;
+ (NSData *)dataWithBase64String:(NSString *)string;

@end
