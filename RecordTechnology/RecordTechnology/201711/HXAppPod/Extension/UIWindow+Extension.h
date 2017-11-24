//
//  UIWindow+Extension.h
//  store
//
//  Created by hudezhi on 15/9/21.
//  Copyright © 2015年 Arthur Wang All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIWindow (Extension)

- (UIViewController *)topVisibleViewController;

+ (UIViewController*) getTopMostViewController; // iOS 7 used

@end
