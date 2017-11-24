//
//  HXBundle.m
//  store
//
//  Created by Arthur Wang on 14-10-13.
//  Copyright (c) 2014年 Arthur Wang All rights reserved.
//

#import "HXBundle.h"

@implementation HXBundle

NSString* HXLocalizedString(NSString* key, NSString* comment) {
    static NSBundle* bundle = nil;
    if (!bundle) {
        NSString* path = [[[NSBundle mainBundle] resourcePath]
                          stringByAppendingPathComponent:@"HXApp.bundle"];
        bundle = [NSBundle bundleWithPath:path];
    }
    
    return [bundle localizedStringForKey:key value:key table:nil];
}

+ (NSBundle*)HXAppBundle {
    NSString* path = [[[NSBundle mainBundle] resourcePath]
                      stringByAppendingPathComponent:@"HXApp.bundle"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
        NSBundle *bundle = [NSBundle bundleWithPath:path];
        if (bundle) {
            return bundle;
        } else {
            NSLog(@"fatal error: HXApp bundle error");
            return nil;
        }
    } else {
        NSLog(@"fatal error: HXApp.bundle not exists, you must include HXApp.bundle in project");
        return nil;
    }
}

+ (NSString *)bundleName{
    return @"HXApp.bundle";
}

@end
