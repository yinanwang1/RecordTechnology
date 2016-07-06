//
//  PushThirdViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/1/29.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "PushThirdViewController.h"

@interface PushThirdViewController ()

@end

@implementation PushThirdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor clearColor];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height / 2.0f, frame.size.width, frame.size.height / 2.0f)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];
    label.text = @"这个是第三页的";
    label.textColor = [UIColor blueColor];
    label.textAlignment= NSTextAlignmentCenter;
    
    [view addSubview:label];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissViewController)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
