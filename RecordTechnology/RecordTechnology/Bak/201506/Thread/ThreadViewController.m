//
//  ThreadViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/6/8.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "ThreadViewController.h"

@interface ThreadViewController ()

@property (nonatomic, strong) NSMutableString *valueMStr;

@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, strong) NSCondition *condition;

@end

@implementation ThreadViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self test3];
    
    
}

- (void)test3
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (YES) {
            NSLog(@"后台执行");
            sleep(1);// 线程睡眠1秒
        }
        
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"主线程执行");
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"延迟2秒");
    });
    
    dispatch_queue_t urls_queue = dispatch_queue_create("blog.devtagng.com", NULL);
    dispatch_async(urls_queue, ^{
        NSLog(@"新创建queue");
    });
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"Test1");
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"Test2");
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"Test3");
    });
    
    
    
    
    
    
}

- (void)test2
{
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
                                                                            selector:@selector(downloadImage:)
                                                                              object:nil];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:operation];
}

- (void)downloadImage:(id)sender
{
    while (YES)
    {
        NSLog(@"Download image is down...");
        
        [NSThread sleepForTimeInterval:2.0f];
    }
}


- (void)test1
{
    self.lock = [[NSLock alloc] init];
    self.condition = [[NSCondition alloc] init];
    
    NSThread *run1 = [[NSThread alloc] initWithTarget:self
                                             selector:@selector(run1)
                                               object:nil];
    
    [run1 start];
    
    [NSThread detachNewThreadSelector:@selector(run2) toTarget:self withObject:nil];
    
    [NSThread detachNewThreadSelector:@selector(run3) toTarget:self withObject:nil];
    
    [NSThread detachNewThreadSelector:@selector(run4) toTarget:self withObject:nil];
    
    
    [NSThread detachNewThreadSelector:@selector(run5) toTarget:self withObject:nil];
}

- (void)run1
{
    while (1)
    {
        [self.condition lock];
        [self.condition wait];
        //        NSLog(@"The current thread is %@. self.valueMStr is %@.", [NSThread currentThread], self.valueMStr);
        
        NSLog(@"run1 display.");
        
        [NSThread sleepForTimeInterval:1];
        
        [self.condition unlock];
    }
}

- (void)run2
{
    
    while (1)
    {
        [self.condition lock];
        [self.condition wait];
        //        NSLog(@"The current thread is %@. self.valueMStr is %@.", [NSThread currentThread], self.valueMStr);
        
        NSLog(@"run2 display.");
        
        [NSThread sleepForTimeInterval:2];
        
        [self.condition unlock];
    }
}

- (void)run3
{
    while (1)
    {
        [self.condition lock];
        [self.condition wait];
        //        NSLog(@"The current thread is %@. self.valueMStr is %@.", [NSThread currentThread], self.valueMStr);
        
        NSLog(@"run3 display.");
        
        [NSThread sleepForTimeInterval:3];
        
        [self.condition unlock];
    }
}

- (void)run4
{
    while (1)
    {
        [self.condition lock];
        [self.condition wait];
        //        NSLog(@"The current thread is %@. self.valueMStr is %@.", [NSThread currentThread], self.valueMStr);
        
        NSLog(@"run4 display.");
        
        [NSThread sleepForTimeInterval:4];
        
        [self.condition unlock];
    }
}

- (void)run5
{
    while (1)
    {
//        NSLog(@"The current thread is %@. self.valueMStr is %@.", [NSThread currentThread], self.valueMStr);
        
        [self.condition lock];
        
        NSLog(@"run5 display.");
        
        [NSThread sleepForTimeInterval:4];
        
        [self.condition signal];
        
        [self.condition unlock];
    }
}



- (IBAction)clickChangeBtn:(id)sender
{
    int value = arc4random();
    NSString *string = @"The value is ";
    
    if ( nil == _valueMStr )
    {
        _valueMStr = [[NSMutableString alloc] initWithString:string];
    }
    
    [self.valueMStr deleteCharactersInRange:NSMakeRange([string length], [self.valueMStr length] - [string length])];
    [self.valueMStr appendString:[NSString stringWithFormat:@"%d", value]];
    
    NSLog(@"self.valueMStr is %@.", self.valueMStr);
    
}




@end
