//
//  NSDataAdditional.h
//  store
//
//  Created by Arthur Wang on 14-10-13.
//  Copyright (c) 2014年 Arthur Wang All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (MBBase64)

+ (id)dataWithBase64EncodedString:(NSString *)string;     //  Padding '=' characters are optional. Whitespace is ignored.
- (NSString *)base64Encoding;

- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;

- (NSData *)AES256EncryptWithKey:(NSString *)key ifPKCS7Padding:(BOOL)padding7;
- (NSData *)AES256DecryptWithKey:(NSString *)key ifPKCS7Padding:(BOOL)padding7;

@end
