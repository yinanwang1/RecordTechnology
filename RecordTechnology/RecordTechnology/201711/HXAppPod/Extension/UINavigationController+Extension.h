//
//  UINavigationController+Extension.h
//  store
//
//  Created by hudezhi on 15/8/17.
//  Copyright (c) 2015年 Arthur Wang All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UINavigationController (Extension)

- (UIViewController *)firstViewControllerOfClass:(NSString *)className;

- (BOOL)containedController:(NSString *)className;

@end
