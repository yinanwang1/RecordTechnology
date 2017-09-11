//
//  Person.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/9/1.
//  Copyright © 2017年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "Person.h"

@implementation Person

void eat(id self, SEL sel)
{
    NSLog(@"%@ %@", self, NSStringFromSelector(sel));
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(eat)) {
        class_addMethod(self, @selector(eat), eat, "v@:");
    }

    return [super resolveInstanceMethod:sel];
}

@end
