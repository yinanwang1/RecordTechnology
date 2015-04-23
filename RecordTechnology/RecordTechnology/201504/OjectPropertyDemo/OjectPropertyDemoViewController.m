//
//  OjectPropertyDemoViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/4/22.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "OjectPropertyDemoViewController.h"

#import "OjectPropertyModule.h"

@interface OjectPropertyDemoViewController ()

@property (nonatomic, strong) OjectPropertyModule *module;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

@implementation OjectPropertyDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _module = [[OjectPropertyModule alloc] init];
    
    _dataDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                @"value1", @"value1",
                @"wahaha", @"value2",
                @"Hello", @"value3",
                @"Good", @"value4",
                @"value5", @"value5",
                @"value6", @"value6",
                @"value7", @"value7",
                @"value8", @"value8",
                @"value9", @"value9",
                @"value10", @"value10",
                @"value11", @"value11",
                @"value12", @"value12",
                @"value13", @"value13",
                @"value14", @"value14",
                @"value15", @"value15",
                @"value16", @"value16",
                @"value17", @"value17",
                nil];
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

- (IBAction)transformDataToClass:(id)sender {
    
    /////使用方法
    
    [self.module reflectDataFromOtherObject:self.dataDic];  //这样就可以完成对象的自动赋值了
    
    
    NSLog(@"self.module is %@.", self.module);
    
}







@end
