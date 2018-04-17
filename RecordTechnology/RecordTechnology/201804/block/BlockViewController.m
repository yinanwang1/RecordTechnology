//
//  BlockViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2018/4/16.
//  Copyright © 2018年 Monkey King. All rights reserved.
//

#import "BlockViewController.h"

@interface BlockViewController ()

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self testBlock];
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

int global_i = 1;  // 全局变量
static int static_global_j = 3;  // 静态全局变量


- (void)testBlock
{
    static int static_k = 3;   //  静态变量
    int val = 4;               // 自动变量

    __weak typeof(self) weakSelf = self;
    void (^myBlock)(void) = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        // Do something
    };

    global_i++;
    static_global_j++;
    static_k++;
    val++;

    NSLog(@"global_i is %d, static_global_j is %d, static_k is %d, val is %d.",
          global_i, static_global_j, static_k, val);

    myBlock();
}


@end











