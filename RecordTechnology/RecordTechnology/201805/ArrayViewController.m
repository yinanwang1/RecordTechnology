//
//  ArrayViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2018/5/15.
//  Copyright © 2018年 Monkey King. All rights reserved.
//

#import "ArrayViewController.h"

#import "ChildViewController.h"

@interface ArrayViewController ()

@end

@implementation ArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self testAarray];
    // TODO
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)testAarray
{
    NSArray *array = @[@"tasdfsf", @"tasdfsf", @"tasdfsf", @"tasdfsf", @"tasdfsf", @"tasdfsf", @"tasdfsf", @"sfsdf"];

    [array makeObjectsPerformSelector:@selector(stringWithFormat:)];
}

- (void)dealWithArray
{
    NSLog(@"sender is ");
}


- (IBAction)onClickPushBtn:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Array" bundle:nil];
    ChildViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ChildViewController"];


    [self.navigationController pushViewController:vc animated:YES];
}




@end
