//
//  YYTestViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/9/25.
//  Copyright © 2017年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "YYTestViewController.h"

#import "YYCopy.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#import <YYKit/YYKit.h>

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
//
//    [self dispatch];
//
//    [self testString];
//
//    [self testStringAndC];
//
//    [self testScanner];
//
//    [self testDecimalNumer];
//
//    [self testUTF32Char];
//
//    [self testStringEncoding];

    [self testStringTrim];
}

- (void)testStringTrim
{
    NSString *str = @"   slfjsf sdf  f\nsldjf   ";

    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *result = [str stringByTrimmingCharactersInSet:set];

    NSLog(@"result is %@.", result);

}

- (void)testStringEncoding
{
//    NSStringEncoding

    NSString *str = @"中文";
    NSData *data = [str dataUsingEncoding:NSJapaneseEUCStringEncoding];

    NSString *test = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];


    NSLog(@"WOW is %@.", test);
}

- (void)testUTF32Char
{
    NSLog(@"stringWithUTF32Char is %@.", [NSString stringWithUTF32Char:49]);
    UTF32Char tst[10] = {50, 52, 50, 50, 52, 50, 50, 52, 50, 78};
    NSLog(@"stringWithUTF32Char is %@.", [NSString stringWithUTF32Chars:tst length:10]);

}

- (void)testDecimalNumer
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *newAmount = [formatter stringFromNumber:[NSNumber numberWithFloat:123]];

    NSLog(@"newAmount is %@.", newAmount);

    NSDecimalNumber *rest = [NSDecimalNumber decimalNumberWithString:@"2.12"];
    NSLog(@"rest is %f", [rest floatValue]);
    NSLog(@"rest is %f", [rest doubleValue]);
    NSDecimalNumber *point = [NSDecimalNumber decimalNumberWithString:@"1.33"];
    NSDecimalNumber *result = [rest decimalNumberBySubtracting:point];
    NSLog(@"result is %@.", result);

    NSDecimalNumber *power = [result decimalNumberByRaisingToPower:2];
    NSLog(@"power is %@.", power);

    for (int i = 0; i < 1000; i++)
    {
        NSString *str = [NSString stringWithUUID];

        NSLog(@"str is %@.", str);
    }
}

- (void)testScanner
{
    NSScanner *scanner = [NSScanner scannerWithString:@"0xfe"];
    unsigned int result = 0;
    if ([scanner scanHexInt:&result]) {
        NSLog(@"result is %d.", result);
    }

}

- (void)testStringAndC
{
    NSMutableString *result = [NSMutableString string];
    unichar c = '2';
    CFStringAppendCharacters((CFMutableStringRef)result, &c, 1);

    NSLog(@"result is %@.", result);
}

- (void)testString
{
    NSString *htmlString = @"http://www.baidu.com/ts???:t/👴🏻👮🏽sdfk/cohja";

    NSLog(@"[htmlString stringByURLEncode] is %@", [htmlString stringByURLEncode]);
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

- (void)network
{
    NSArray *typeStrings2G = @[CTRadioAccessTechnologyEdge,
                               CTRadioAccessTechnologyGPRS,
                               CTRadioAccessTechnologyCDMA1x];

    NSArray *typeStrings3G = @[CTRadioAccessTechnologyHSDPA,
                               CTRadioAccessTechnologyWCDMA,
                               CTRadioAccessTechnologyHSUPA,
                               CTRadioAccessTechnologyCDMAEVDORev0,
                               CTRadioAccessTechnologyCDMAEVDORevA,
                               CTRadioAccessTechnologyCDMAEVDORevB,
                               CTRadioAccessTechnologyeHRPD];

    NSArray *typeStrings4G = @[CTRadioAccessTechnologyLTE];
    CTTelephonyNetworkInfo *teleInfo= [[CTTelephonyNetworkInfo alloc] init];
    NSString *accessString = teleInfo.currentRadioAccessTechnology;
    if ([typeStrings4G containsObject:accessString]) {
        NSLog(@"4G网络");
    } else if ([typeStrings3G containsObject:accessString]) {
        NSLog(@"3G网络");
    } else if ([typeStrings2G containsObject:accessString]) {
        NSLog(@"2G网络");
    } else {
        NSLog(@"未知网络");
    }
}




@end
