//
//  AnimatedViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2018/9/7.
//  Copyright © 2018年 Monkey King. All rights reserved.
//

#import "AnimatedViewController.h"

#import "GreenViewController.h"

@interface AnimatedViewController ()

@end

@implementation AnimatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onClickPushBtn:(id)sender {

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Animated" bundle:nil];
    GreenViewController *green = [storyboard instantiateViewControllerWithIdentifier:@"GreenViewController"];

    [self.navigationController pushViewController:green animated:YES];
    
}



@end
