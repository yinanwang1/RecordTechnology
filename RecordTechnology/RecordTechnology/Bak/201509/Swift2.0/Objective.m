//
//  Objective.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/10/8.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "Objective.h"

#import "RecordTechnology-Swift.h"

@implementation Objective

- (void)sayHello
{
    NSLog(@"Hello, I am Objective-c.");
    
    StudentClass *classTest = [[StudentClass alloc] init];
    
    [classTest sayHello];
}

@end
