//
//  NSObject+Property.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/9/1.
//  Copyright © 2017年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "NSObject+Property.h"

static const char *key = "name";

@implementation NSObject (Property)

- (NSString *)name
{
    return objc_getAssociatedObject(self, key);
}

- (void)setName:(NSString *)name
{
    objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
