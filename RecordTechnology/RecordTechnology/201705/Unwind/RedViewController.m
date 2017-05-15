//
//  RedViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/5/15.
//  Copyright © 2017年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "RedViewController.h"

@interface RedViewController ()

@end

@implementation RedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewControlloerUnwindSegue:(UIStoryboardSegue *)unwindSegue
{
    NSLog(@"啊哈哈塑料袋福建省两地分居");
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
