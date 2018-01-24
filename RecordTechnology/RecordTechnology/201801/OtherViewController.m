//
//  OtherViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2018/1/24.
//  Copyright © 2018年 Monkey King. All rights reserved.
//

#import "OtherViewController.h"

#import "PresentViewController.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

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

- (IBAction)onClickPresentVC:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LeftStoryboard" bundle:nil];
    PresentViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"PresentViewController"];

    [self presentViewController:vc animated:YES completion:nil];
}





@end
