//
//  LumberjackViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/7/15.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "LumberjackViewController.h"

#import "DDLog.h"
#import "DDASLLogger.h"
#import "DDTTYLogger.h"

static const int ddLogLevel = LOG_LEVEL_ERROR;  // 控制打印的日志级别。 如果设置为error级别，name就仅仅打印error的日志。 如果设置为verbose级别，name将打印所有的日志。

@interface LumberjackViewController ()

@end

@implementation LumberjackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化日志，在项目中运行打印到那些日志
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    DDLogError(@"Cry");
    
    DDLogVerbose(@"What?");
    
    
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

@end
