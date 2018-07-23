//
//  SafeViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2018/7/6.
//  Copyright © 2018年 Monkey King. All rights reserved.
//

#import "SafeViewController.h"

@interface SafeViewController ()

@property (atomic, strong) NSString *name;

@end

@implementation SafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @synchronized(self){
            NSLog(@"第一个线程同步操作开始");
            sleep(3);
            NSLog(@"第一个线程同步操作结束");
        }
    });


    NSString *s = [NSString string];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @synchronized(s){
            NSLog(@"第二个线程同步操作");
        }
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
