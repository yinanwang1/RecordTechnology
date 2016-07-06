//
//  ChatViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/4/23.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "ChatViewController.h"

#import "NavigationLikeWechatViewController.h"
#import "MainTabBarViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(returnToChatVC)];
    
    
    self.navigationItem.leftBarButtonItem = leftButton;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
    
//    NSMutableArray *mArr = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
//    
//    [mArr removeObjectAtIndex:1];
//    
//    self.navigationController.viewControllers = mArr;
    
    
    
}

- (void)returnToChatVC
{    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
