//
//  ObjcRunTimeViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/6/10.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "ObjcRunTimeViewController.h"

#import "CustomClass.h"
#import "CustomClassOther.h"
#import "TestClass.h"
#include <objc/runtime.h>

@interface ObjcRunTimeViewController ()

@end

@implementation ObjcRunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self setClassTest];
    
//    [self getClassName];
    
    [self oneParam];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Private Methods

//- (void)copyObj
//{
//    CustomClass *obj = [[CustomClass alloc] init];
//    NSLog(@"%p", &obj);
//    
//    id objTest = object_copy(obj, sizeof(obj));
//    
//    NSLog(@"%p", &objTest);
//    
//    [objTest fun1];
//}

- (void)setClassTest
{
    CustomClass *obj = [[CustomClass alloc] init];
    
    [obj fun1];
    
    
    Class aClass = object_setClass(obj, [CustomClassOther class]);
    
    NSLog(@"aClass :%@", NSStringFromClass(aClass));
    NSLog(@"obj class: %@", NSStringFromClass([obj class]));
    
    
    [obj fun1];
    
    
}


- (void)getClassName
{
    CustomClass *obj = [[CustomClass alloc] init];
    
    NSString *className = [NSString stringWithCString:object_getClassName(obj) encoding:NSUTF8StringEncoding];
    
    NSLog(@"className is %@.", className);
}

int cfunction(id self, SEL _cmd, NSString *str)
{
    NSLog(@"%@", str);
    
    return 10;
}

- (void)oneParam
{
    TestClass *instance = [[TestClass alloc] init];
    
    class_addMethod([TestClass class], @selector(ocMethod:), (IMP)cfunction, "i@:@");
    
    if ( [instance respondsToSelector:@selector(ocMethod:)] )
    {
        NSLog(@"Yes, instance respondsToSelector:@selector(ocMethod:)");
    }
    else
    {
        NSLog(@"Sorry");
    }
    
    int a = (int)[instance ocMethod:@"我是OC的method，C语言实现的。"];
    
    NSLog(@"a is %d.", a);
    
    
}


@end
