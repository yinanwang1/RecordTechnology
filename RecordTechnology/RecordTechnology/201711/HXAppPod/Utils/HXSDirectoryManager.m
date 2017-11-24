//
//  HXSDirectoryManager.m
//  store
//
//  Created by Arthur Wang on 14/10/26.
//  Copyright (c) 2014年 Arthur Wang All rights reserved.
//

#import "HXSDirectoryManager.h"
#import <sys/xattr.h>
#import "NSString+Addition.h"

@implementation HXSDirectoryManager

+ (NSString *) getLibraryDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return documentsDirectory;
}

+ (NSString *) getCachesDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSMutableString *path = [paths objectAtIndex:0];
    
    return path;
}

+ (BOOL) createDirectoryAtCachesWithName:(NSString *)dirName
{
    NSString *dirPath = [[HXSDirectoryManager getCachesDirectory] stringByAppendingPathComponent:dirName];
    
    return [HXSDirectoryManager createDirectoryAtPath:dirPath];
}

+ (NSString *) getDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return documentsDirectory;
}

+ (NSArray*) enumarateDirectoryAtPath:(NSString *)path inCaches:(BOOL)isInCaches
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *enumPath;
    NSArray *enumArray;
    
    if (isInCaches)
        enumPath = [NSString stringWithString:[[HXSDirectoryManager getCachesDirectory] stringByAppendingPathComponent:path]];
    else
        enumPath = [NSString stringWithString:path];
    
    
    enumArray = [fileManager contentsOfDirectoryAtPath:enumPath error:nil];
    
    return enumArray;
}

+ (NSString *) getTempDirectory
{
    return NSTemporaryDirectory();
}

+ (BOOL) createDirectoryAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path isDirectory:nil])
    {
        return NO;
    }
    else
    {
        return [fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:NULL error:NULL];
    }
    
}

//+ (NSArray*) enumarateDirectoryAtPath:(NSString *)path inDocuments:(BOOL)isInDocuments {
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *enumPath;
//    NSArray *enumArray;
//
//    if (isInDocuments)
//        enumPath = [NSString stringWithString:[[DirectoryManager getDocumentsDirectory] stringByAppendingPathComponent:path]];
//    else
//        enumPath = [NSString stringWithString:path];
//
//
//    enumArray = [fileManager contentsOfDirectoryAtPath:enumPath error:nil];
//
//    return enumArray;
//}

//+ (BOOL) createDirectoryAtDocumentsWithName:(NSString *)dirName {
//    NSString *dirPath = [[DirectoryManager getDocumentsDirectory] stringByAppendingPathComponent:dirName];
//
//    return [DirectoryManager createDirectoryAtPath:dirPath];
//}

//+ (NSMutableArray*)createURLStartWith:(NSString *)start AtPath:(NSString *)path inDocuments:(BOOL)isInDocuments {
//    NSMutableArray *result = [[NSMutableArray alloc] init];
//    NSArray *fileList = [DirectoryManager enumarateDirectoryAtPath:path inDocuments:isInDocuments];
//
//    if (path != nil) {
//        for (int i = 0; i < fileList.count; ++i) {
//            NSString *tmpString = [[NSString alloc] initWithFormat:@"%@%@/%@", start, path, [fileList objectAtIndex:i]];
//            [result addObject:tmpString];
//            [tmpString release];
//        }
//    } else {
//        for (int i = 0; i < fileList.count; ++i) {
//            NSString *tmpString = [[NSString alloc] initWithFormat:@"%@%@", start, [fileList objectAtIndex:i]];
//            [result addObject:tmpString];
//            [tmpString release];
//        }
//    }
//    return result;
//}

+ (void)moveFilesFrom:(NSString *)fromFile to:(NSString *)toFile
{
    NSError * error;
    NSArray * files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:fromFile error:&error];
    
    if(files && files.count > 0)
    {
        for(NSString * selectedFile in files)
        {
            NSString * fromFilePath = [fromFile stringByAppendingPathComponent: selectedFile];
            NSString * toFilePath = [toFile stringByAppendingPathComponent: selectedFile];
            
            BOOL isDir;
            //判断是否是为目录
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:fromFilePath isDirectory:&isDir] && isDir)
            {//目录
                
                [[NSFileManager defaultManager] createDirectoryAtPath:toFilePath withIntermediateDirectories:NO attributes:nil error:nil];
                
                [HXSDirectoryManager moveFilesFrom:fromFilePath to:toFilePath];
            }
            else
            {//文件
                [[NSFileManager defaultManager] moveItemAtPath:fromFilePath toPath:toFilePath error:nil];
            }
        }
    }
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    if(URL == nil)
        return NO;
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    [URL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];

    return error == nil;
}

+ (NSString *)getAdImagePath:(NSString *)image_url {
    NSString *imagePath = [HXSDirectoryManager getCachesDirectory];
    imagePath = [imagePath stringByAppendingPathComponent:@"LaunchAd"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:imagePath isDirectory:nil])
    {
        [HXSDirectoryManager createDirectoryAtPath:imagePath];
    }
    imagePath = [imagePath stringByAppendingString:[NSString md5:image_url]];
    return imagePath;
}

@end
