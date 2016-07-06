//
//  ChatDetailViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/4/23.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "ChatDetailViewController.h"

#import "MainTabBarViewController.h"

@interface ChatDetailViewController ()

@end

@implementation ChatDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)pushToChatVC:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NavigationLikeWechat" bundle:[NSBundle mainBundle]];
//    
//    MainTabBarViewController *mainVC = (MainTabBarViewController *)storyboard.instantiateInitialViewController;
//    
//
//    
//    [mainVC setSelectedViewController:[mainVC.viewControllers objectAtIndex:0]];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"test1"
                                                        object:nil];
    
    
}

@end
