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
    
}




@end
