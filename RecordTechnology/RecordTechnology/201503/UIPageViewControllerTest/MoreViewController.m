//
//  MoreViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/26.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *myWebView;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    
    CGRect frame = self.view.bounds;
    self.myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, frame.size.width, frame.size.height)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.myWebView loadHTMLString:self.dataObject baseURL:nil];
    [self.view addSubview:self.myWebView];
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
