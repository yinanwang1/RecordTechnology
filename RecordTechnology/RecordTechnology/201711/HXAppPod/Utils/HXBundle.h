//
//  HXBundle.h
//  store
//
//  Created by Arthur Wang on 14-10-13.
//  Copyright (c) 2014年 Arthur Wang All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBundle : NSObject

NSString* HXLocalizedString(NSString* key, NSString* comment);

+ (NSBundle*)HXAppBundle;
+ (NSString *)bundleName;

@end
