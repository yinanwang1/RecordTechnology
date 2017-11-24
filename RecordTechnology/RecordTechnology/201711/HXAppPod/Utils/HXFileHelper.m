//
//  HXFileHelper.m
//  store
//
//  Created by Arthur Wang on 14-10-14.
//  Copyright (c) 2014年 Arthur Wang All rights reserved.
//

#import "HXFileHelper.h"
#define HX_DATA_PATH @"HXData"

@implementation HXFileHelper

+ (NSString *)absolutePathForDataFile:(NSString *)fileName {
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    if (dirs == nil || [dirs count] == 0)
        return nil;
    NSString *path = [[dirs objectAtIndex:0] stringByAppendingPathComponent:HX_DATA_PATH];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error];
        if (error != nil) {
//            HXLogError(@"HXFileHelper", @"Failed to create directory: %@", path);
            return nil;
        } else
            return [path stringByAppendingPathComponent:fileName];
    } else
        return [path stringByAppendingPathComponent:fileName];
}

+ (BOOL)existsDataFile:(NSString *)fileName {
    return [[NSFileManager defaultManager] fileExistsAtPath:[self absolutePathForDataFile:fileName]];
}

+ (void)writeDataFile:(NSString *)fileName withData:(NSData *)data {
    NSString *absFile = [self absolutePathForDataFile:fileName];
    [data writeToFile:absFile atomically:YES];
}

+ (NSString *)absolutePathForDocumentFile:(NSString *)docFile {
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if (dirs == nil || [dirs count] == 0)
        return nil;
    else
        return [[dirs objectAtIndex:0] stringByAppendingPathComponent:docFile];
}

+ (void)writeDocumentFile:(NSString *)fileName withData:(NSData *)data {
    NSString *absFile = [self absolutePathForDocumentFile:fileName];
    [data writeToFile:absFile atomically:YES];
}

+ (BOOL)existsDocumentFile:(NSString *)fileName {
    return [[NSFileManager defaultManager] fileExistsAtPath:[self absolutePathForDocumentFile:fileName]];
}

@end

