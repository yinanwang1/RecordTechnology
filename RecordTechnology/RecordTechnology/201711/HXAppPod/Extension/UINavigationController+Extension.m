//
//  UINavigationController+Extension.m
//  store
//
//  Created by hudezhi on 15/8/17.
//  Copyright (c) 2015年 Arthur Wang All rights reserved.
//

#import "UINavigationController+Extension.h"

@implementation UINavigationController (Extension)

- (UIViewController *)firstViewControllerOfClass:(NSString *)className
{
    NSArray *controllers = self.viewControllers.reverseObjectEnumerator.allObjects;

    NSArray *result = [controllers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject isKindOfClass:NSClassFromString(className)];
    }]];
        
    if (result.count > 0) {
        return result[0];
    }
    
    return nil;
}

- (BOOL)containedController:(NSString *)className
{
    NSArray *controllers = self.viewControllers.reverseObjectEnumerator.allObjects;
    
    NSArray *result = [controllers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject isKindOfClass:NSClassFromString(className)];
    }]];
    
    return (result.count > 0);
}

@end
