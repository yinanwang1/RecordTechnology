//
//  YYTestViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/9/25.
//  Copyright © 2017年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "YYTestViewController.h"

#import "YYCopy.h"

typedef void (^tst)(NSString *test, NSString *tst2);

@interface YYTestViewController ()

@property (nonatomic, strong) YYReachability *reachability;

@property (nonatomic, copy) void (^block)(NSString *tst);

@end

@implementation YYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self testReachability];
//
//    [self testCopy];
//
//    [self readDoc];
//
//    [self savePassword];
//
//    [self readPassword];

    [self dispatch];
}


- (void)testReachability
{
    YYReachability *reachability = [YYReachability reachability];

    reachability.notifyBlock = ^(YYReachability *reachability){
        NSLog(@"reachability.flags is %d.", reachability.flags);
        NSLog(@"reachability.status is %lu.", (unsigned long)reachability.status);
        NSLog(@"reachability.wwanStatus is %lu.", (unsigned long)reachability.wwanStatus);
    };

    self.reachability = reachability;
}

- (void)testCopy
{
    YYCopy *copy = [[YYCopy alloc] init];

    copy.name = @"不凑哦";
    copy.age = @"123123";


    YYCopy *tempCopy = [copy copy];

    NSLog(@"tempCopy is %@", tempCopy);

    // 保存
    NSString  *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"stu.data"];

    [NSKeyedArchiver archiveRootObject:tempCopy toFile:path];
}

- (void)readDoc
{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"stu.data"];

    YYCopy *copy = [NSKeyedUnarchiver unarchiveObjectWithFile:path];

    NSLog(@"copy.name is %@, copy.age is %@.",copy.name, copy.age);
}

- (void)savePassword
{
    [YYKeychain setPassword:@"1234567890" forService:@"1234" account:@"wangyinan"];
}

- (void)readPassword
{
    NSString *password = [YYKeychain getPasswordForService:@"1234" account:@"wangyinan"];

    NSLog(@"password is %@.", password);
}

- (void)dispatch
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    for (int i = 0; i < 100; i++) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            NSLog(@"i is %i", i);
            sleep(2);

            dispatch_semaphore_signal(semaphore);

            NSLog(@"semaphore is %@.", semaphore.description);
        });
    }

    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);

    NSLog(@"结果");
}



@end
