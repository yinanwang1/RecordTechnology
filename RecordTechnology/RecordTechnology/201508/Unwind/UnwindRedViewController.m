//
//  UnwindViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/8/8.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "UnwindRedViewController.h"

#import "UnwindYellowViewController.h"
#import "UnwindBlueViewController.h"

@interface UnwindRedViewController ()

@end

@implementation UnwindRedViewController

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


// 参考  http://www.cnblogs.com/ZJUT-jiangnan/p/3902638.html

- (IBAction)unwindSegueToRedViewController:(UIStoryboardSegue *)segue
{
    UIViewController *sourceViewController = segue.sourceViewController;
    
    if ([sourceViewController isKindOfClass:[UnwindYellowViewController class]]) {
        NSLog(@"From yellow vc");
    } else if ([sourceViewController isKindOfClass:[UnwindBlueViewController class]]) {
        NSLog(@"From blue vc");
    }
}


@end
