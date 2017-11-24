//
//  HXSLocalHelper.m
//  store
//
//  Created by Arthur Wang on 14/10/27.
//  Copyright (c) 2014年 Arthur Wang All rights reserved.
//

#import "HXSLocalHelper.h"

@implementation HXSLocalHelper

+ (BOOL) isLocaleChinese
{
#if INTERNATIONAL_VERSION
    return NO;
#endif
    
    static BOOL isInited = NO;
    static BOOL isChinese = NO;
    if (!isInited)
    {
        isInited = YES;
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        NSArray* languages = [defaults objectForKey:@"AppleLanguages"];
        NSString* currentLanguage = [languages objectAtIndex:0];
        
        if ([currentLanguage isEqualToString:@"zh-Hans"])
        {
            isChinese = YES;
        }
        else
        {
            isChinese = NO;
        }
    }
    return isChinese;
}

+ (NSString *) currentAppLanguage
{
#if INTERNATIONAL_VERSION
    return @"en";
#endif
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defaults objectForKey:@"AppleLanguages"];
    NSString* currentLanguage = [languages objectAtIndex:0];
    
    //    NSArray * array = [[NSBundle mainBundle] preferredLocalizations];
    //    if ([array count] > 0)
    //    {
    //        NSString * str = [array objectAtIndex:0];
    //        if ([str length] > 0)
    //            return str;
    //    }
    
    return currentLanguage;
}

@end
