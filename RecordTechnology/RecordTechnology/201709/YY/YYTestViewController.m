//
//  YYTestViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/9/25.
//  Copyright © 2017年 MonkeyKing. All rights reserved.
//

#import "YYTestViewController.h"

#import "YYCopy.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#import "BezierPathView.h"

#import <YYKit/YYKit.h>
#import "RecordTechnology-Swift.h"

typedef void (^tst)(NSString *test, NSString *tst2);

@interface YYTestViewController () <YYTestViewControllerSubDelegate>

@property (nonatomic, strong) YYReachability *reachability;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UITextField *textField;



@property (nonatomic, copy) void (^block)(NSString *tst);

@end

@implementation YYTestViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

//    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

//    [self.navigationController setNavigationBarHidden:NO];
}

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
//
//    [self testStringTrim];
//
//    [self testPath];
//
//    [self testPath2];
//
//    [self testPredicate];
//
//    [self testRegular];
//
//    [self testExpression];
//
//    [self testHex];
//
//    [self testBase64];
//
//    [self testPropertyList];
//
//    [self testRandom];
//
//    [self testOrdinal];
//
//    [self testImage];
//
//    [self testTextField];
//
//    [self testDevice];
//
//    [self testApplication];
//
//    [self testBezierPath];
//
//    [self testLayer];

    [self testDic];
}

- (void)testDic
{
    NSDictionary *dic = @{@"tst":@"1231", @"sdfsdf":@"12323"};

//    if (5 < maximumNumberOfLoginAttemptes) {
//        NSLog(@"maximumNumberOfLoginAttemptes is %@", maximumNumberOfLoginAttemptes);
//    }
}

- (void)testLayer
{
    [self.imageView.layer setLayerShadow:[UIColor redColor]
                                  offset:CGSizeMake(10, 10)
                                  radius:3.0f];
}

- (void)testBezierPath
{
//    BezierPathView *view = [[BezierPathView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
//
//    [view setCenter:self.view.center];
//
//    [self.view addSubview:view];

}

- (void)testApplication
{
    UIApplication *app = [UIApplication sharedApplication];

    NSLog(@"documentsURL is %@.", [app documentsURL]);
    NSLog(@"documentsPath is %@.", [app documentsPath]);
    NSLog(@"appBundleName is %@.", [app appBundleName]);
    NSLog(@"appBundleID is %@.", [app appBundleID]);
}

- (void)testDevice
{
    int64_t memory = [[UIDevice currentDevice] memoryTotal];
    int64_t memoryUsed = [[UIDevice currentDevice] memoryUsed];

    NSLog(@"memory is %lld", memory);
    NSLog(@"memoryUsed is %lld", memoryUsed);
}

- (void)testTextField
{
    [self.textField becomeFirstResponder];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textField setSelectedRange:NSMakeRange(2, 3)];
    });
}

- (void)testImage
{
    UIImage *image = [UIImage imageNamed:@"Animation1"];

    [self.imageView setImage:image];

    image = [image imageByBlurDark];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.imageView setImage:image];
    });
}

- (void)testOrdinal
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:24 * 3600];
    NSInteger weekdayOrdinal = [date weekdayOrdinal];

    NSLog(@"weekday is %zd.", [date weekday]);
    NSLog(@"weekdayOrdinal is %zd.", weekdayOrdinal);
    NSLog(@"yearForWeekOfYear is %zd.", [date yearForWeekOfYear]);
}

- (void)testRandom
{
    for (int i = 0; i < 100; i++) {
        uint32_t random = arc4random_uniform((uint32_t)100);

        NSLog(@"random is %d.", random);
    }
}

- (void)testPropertyList
{
    NSDictionary *dic = @{@"test1":@"wang", @"test2":@"yinan"};

    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"test.txt"];
    [dic writeToFile:path atomically:YES];


    NSData *data = [NSData dataWithContentsOfFile:path];


    NSDictionary *outDic = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:nil];

    NSLog(@"outDic is %@.", outDic);

}

- (void)testBase64
{
    NSString *str = @"1";

    NSString *base64Str = [str base64EncodedString];

    NSLog(@"base64Str is %@.", base64Str);
}

- (void)testHex
{
    NSString *str = @"123456";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];

    NSLog(@"data is %@.", data);

    const unsigned char *bytes = data.bytes;
    for (int i = 0; i < data.length; i++, bytes++) {
        NSLog(@"hex is %02X ", *bytes);
    }
}

- (void)testExpression
{
    NSString *regex = @"\\-\\d*\\.";
    NSString *str = @"-123123.-1231a12.";
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];

    NSArray *matches = [regular matchesInString:str options:0 range:NSMakeRange(0, str.length)];

    for (NSTextCheckingResult *match in matches) {
        NSRange range = [match range];
        NSString *mStr = [str substringWithRange:range];

        NSLog(@"result is %@", mStr);
    }
}

- (void)testRegular
{
    NSString *url = @"12342@12.1131123@q.q.com";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^@]*\\." options:0 error:&error];
    if (!error) {
        NSTextCheckingResult *match = [regex firstMatchInString:url options:0 range:NSMakeRange(0, [url length])];
        if (match) {
            NSString *result = [url substringWithRange:match.range];

            NSLog(@"result is %@", result);
        }
    } else {
        NSLog(@"error is %@", error);
    }
}

- (void)testPredicate
{
    NSString *regex = @"^[a-z0-9A-Z]*$";

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

    NSString *str = @"hello100&";

    if ([predicate evaluateWithObject:str]) {
        NSLog(@"Match");
    } else {
        NSLog(@"Not Match");
    }
}

- (void)testPath2
{
    NSString *str = @"home/test/app/download@3.5x.png";

    NSLog(@"path scale is %f", str.pathScale);
}

- (void)testPath
{
    NSString *path = [NSString pathWithComponents:@[@"home", @"tmp", @"picture"]];

    NSLog(@"path is %@.", path);

    NSArray *pathArr = [@"home/tmp/picture" pathComponents];

    NSLog(@"pathArr is %@", pathArr);

    NSLog(@"home/tmp/picture is %d", path.isAbsolutePath);
    NSLog(@"/home/tmp/picture is %d", @"/home/tmp/picture".isAbsolutePath);

    NSLog(@"%@", path.lastPathComponent);

    NSLog(@"%@", path.stringByDeletingLastPathComponent);

    NSLog(@"%@", [path stringByAppendingPathComponent:@"my"]);

    NSLog(@"%@",@"home/tmp/picture.png".pathExtension);
    NSLog(@"%@",@"home/tmp/picture.png".stringByDeletingPathExtension);

    NSLog(@"%@", [path stringByAppendingPathExtension:@"jpg"]);

    NSLog(@"NSHomeDirectory  %@", NSHomeDirectory());
    NSLog(@"NSUserName  %@", NSUserName());
    NSLog(@"NSFullUserName  %@", NSFullUserName());
    NSLog(@"NSHomeDirectoryForUser  %@", NSHomeDirectoryForUser(@"wang"));
    NSLog(@"NSTemporaryDirectory  %@", NSTemporaryDirectory());
    NSLog(@"NSOpenStepRootDirectory  %@", NSOpenStepRootDirectory());


    NSString *wholePath = [NSString stringWithFormat:@"%@/test/picture", NSHomeDirectory()];
    NSLog(@"%@", wholePath.stringByAbbreviatingWithTildeInPath);
    NSString *tildePath = @"~sfsdf/app/download".stringByAbbreviatingWithTildeInPath;
    NSLog(@"tildePath is %@", tildePath.stringByExpandingTildeInPath);

    NSLog(@"stringByStandardizingPath is %@.", @"../private".stringByStandardizingPath);

    NSLog(@"stringByResolvingSymlinksInPath is %@.", tildePath.stringByResolvingSymlinksInPath);
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



- (void)YYTestViewController:(NSString *)test {
    NSLog(@"YYTestViewController is %@.", test);
}

- (void)YYTestViewControllerSubDelegate:(NSString *)tst
{
    NSLog(@"YYTestViewControllerSubDelegate is %@.", tst);

    YYTestSwiftViewController *vc = [[YYTestSwiftViewController alloc] init];

    [self.navigationController pushViewController:vc animated:YES];
}




@end
