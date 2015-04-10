//
//  ActivityViewControllerViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/4/10.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "ActivityViewControllerViewController.h"

@interface ActivityViewControllerViewController ()

@end

@implementation ActivityViewControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)clickShareBtn:(id)sender {
    
    NSArray *array = @[@"test1", @"test2"];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:array applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES
                     completion:^{
                         NSLog(@"Air");
                     }];
    
}

@end
