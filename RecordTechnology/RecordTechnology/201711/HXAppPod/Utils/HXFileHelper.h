//
//  HXFileHelper.h
//  store
//
//  Created by Arthur Wang on 14-10-14.
//  Copyright (c) 2014年 Arthur Wang All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXFileHelper : NSObject


//return ...App/Library/HXData/fileName
+ (NSString *)absolutePathForDataFile:(NSString *)fileName;
+ (BOOL)existsDataFile:(NSString *)fileName;
+ (void)writeDataFile:(NSString *)fileName withData:(NSData *)data;

+ (NSString *)absolutePathForDocumentFile:(NSString *)docFile;
+ (BOOL)existsDocumentFile:(NSString *)fileName;
+ (void)writeDocumentFile:(NSString *)fileName withData:(NSData *)data;

@end
