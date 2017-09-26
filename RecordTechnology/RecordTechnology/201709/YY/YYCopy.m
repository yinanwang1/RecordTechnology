//
//  YYCopy.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/9/26.
//  Copyright © 2017年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "YYCopy.h"

#define k_name @"name"
#define k_age  @"age"

@implementation YYCopy

- (id)copyWithZone:(NSZone *)zone
{
    YYCopy *model = [[[self class] allocWithZone:zone] init];
    model.name = self.name;
    model.age = self.age;

    return model;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:k_name];
        self.age = [aDecoder decodeObjectForKey:k_age];
    }

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:k_name];
    [aCoder encodeObject:_age forKey:k_age];
}


@end
