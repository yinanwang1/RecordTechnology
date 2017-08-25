//
//  SafariViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/8/25.
//  Copyright © 2017年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "SafariViewController.h"

#import <SafariServices/SafariServices.h>

@interface SafariViewController ()

@end

@implementation SafariViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showSafariVC:(id)sender
{
    SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];

    [self.navigationController pushViewController:vc animated:YES];
}



@end
