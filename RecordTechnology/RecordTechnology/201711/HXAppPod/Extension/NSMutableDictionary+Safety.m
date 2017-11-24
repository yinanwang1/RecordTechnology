//
//  NSMutableDictionary+Safety.m
//  store
//
//  Created by ArthurWang on 15/7/31.
//  Copyright (c) 2015年 Arthur Wang All rights reserved.
//

#import "NSMutableDictionary+Safety.h"

@implementation NSMutableDictionary (Safety)


- (void)setObjectExceptNil:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (nil == anObject) {
        return;
    }
    
    [self setObject:anObject forKey:aKey];
}

@end
