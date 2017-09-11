//
//  RuntimeViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/9/1.
//  Copyright © 2017年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "RuntimeViewController.h"

//#import "UIImage+Image.h"
#import "Person.h"
#import "NSObject+Property.h"

@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    UIImage *image = [UIImage imageNamed:@"123"];
//
//    NSLog(@"image is %@", image);

//    Person *p = [[Person alloc] init];
//
//    [p performSelector:@selector(eat)];

//    NSObject *objc = [[NSObject alloc] init];
//
//    objc.name = @"呵呵哒";
//
//    NSLog(@"name is %@", objc.name);

    unsigned int outCount = 0;

    objc_property_t *properties = class_copyPropertyList([Person class], &outCount);

    NSLog(@"outCount is %d", outCount);

    for (NSInteger i = 0; i < outCount; i++) {
        NSString *name = @(property_getName(properties[i]));
        NSString *attributes = @(property_getAttributes(properties[i]));

        NSLog(@"%@----%@", name, attributes);
    }

    NSLog(@"[super class] is %@.",NSStringFromClass([super class]));


}


@end
