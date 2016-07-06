//
//  CopyTestViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/4/15.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "CopyTestViewController.h"

@interface CopyTestViewController ()

@property (nonatomic, strong) NSMutableDictionary *outMDic;
@property (nonatomic, strong) NSArray *array1;
@property (nonatomic, strong) NSArray *array2;


@end

@implementation CopyTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _array1 = @[@"1", @"2"];
    _array2 = @[@"3", @"4"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                         _array1, @"object1",
                         _array2, @"object2", nil];
    
    
    
    self.outMDic = dic;
    
    self.outMDic = [dic mutableCopy];
    
    
    
    
    
    
    
    
    
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

@end
