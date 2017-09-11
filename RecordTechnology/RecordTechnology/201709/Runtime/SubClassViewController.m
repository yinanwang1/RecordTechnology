//
//  SubClassViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/9/6.
//  Copyright © 2017年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "SubClassViewController.h"

@interface SubClassViewController ()

@end

@implementation SubClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self testClass];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testClass
{
    BOOL result = YES;

    result = [self isKindOfClass:[RuntimeViewController class]];
    NSLog(@"[self isKindOfClass:[RuntimeViewController class] is %@.", @(result));

    result = [self isMemberOfClass:[RuntimeViewController class]];
    NSLog(@"[self isMemberOfClass:[RuntimeViewController class] is %@.", @(result));

    result = [self isMemberOfClass:[SubClassViewController class]];
    NSLog(@"[self isMemberOfClass:[SubClassViewController class]] is %@.", @(result));

    result = [SubClassViewController isSubclassOfClass:[RuntimeViewController class]];
    NSLog(@"[SubClassViewController isSubclassOfClass:[RuntimeViewController class]] is %@.", @(result));

    result = [SubClassViewController isSubclassOfClass:[SubClassViewController class]];
    NSLog(@"[SubClassViewController isSubclassOfClass:[SubClassViewController class]] is %@.", @(result));

    result = [RuntimeViewController isSubclassOfClass:[SubClassViewController class]];
    NSLog(@"[SubClassViewController isSubclassOfClass:[SubClassViewController class]] is %@.", @(result));
}


@end
