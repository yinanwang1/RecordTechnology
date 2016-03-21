//
//  JSPatchViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/3/21.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "JSPatchViewController.h"

#import "JPEngine.h"

@interface JSPatchViewController ()

@end

@implementation JSPatchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [JPEngine startEngine];
    
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:sourcePath
                                                 encoding:NSUTF8StringEncoding
                                                    error:nil];
    [JPEngine evaluateScript:script];
    
    UIView *tempView = [self genView];
    
    [self.view addSubview:tempView];
}

- (UIView *)genView
{
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    [tempView setBackgroundColor:[UIColor redColor]];
    
    return tempView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
