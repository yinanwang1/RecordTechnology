//
//  UtilsMacro.h
//  RecordTechnology
//
//  Created by ArthurWang on 15/6/17.
//  Copyright (c) 2015年 MonkeyKing. All rights reserved.
//

#ifndef RecordTechnology_UtilsMacro_h
#define RecordTechnology_UtilsMacro_h

#define RGB(r, g, b)                        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define OBJISNULL(o) (o == nil || [o isKindOfClass:[NSNull class]] || ([o isKindOfClass:[NSString class]] && [o length] == 0))
#define OBJUSFUL(o, className) ((o != nil) && [o isKindOfClass:[className class]])
#define APP ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define SharedApplication                   [UIApplication sharedApplication]
#define ScreenWidth                         [UIScreen mainScreen].bounds.size.width
#define ScreenHeight                        [UIScreen mainScreen].bounds.size.height

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


#ifdef DEBUG
#define DLog(fmt,...) NSLog(fmt, ##__VA_ARGS__);
#else
// If debug mode hasn't been enabled, don't do anything when the macro is called
#define DLog(...)
#endif

#endif
