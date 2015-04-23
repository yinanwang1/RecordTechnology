//
//  MainChatViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/4/23.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "MainChatViewController.h"

#import "ChatViewController.h"

@interface MainChatViewController ()

@end

@implementation MainChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(testShow)
                                                 name:@"showChatView"
                                               object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
}

- (void)testShow
{
//    ChatViewController *chatVC = [[ChatViewController alloc] init];
//    
//    [self.navigationController pushViewController:chatVC animated:YES];
    
    [self performSegueWithIdentifier:@"showVCVC" sender:nil];
    
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
