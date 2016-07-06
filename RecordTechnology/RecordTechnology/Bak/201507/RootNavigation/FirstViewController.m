//
//  FirstViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/7/18.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

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

- (void)addRightBarButtonItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:BAR_BUTTON_ITEM_FRAME];
    [rightBtn setTitle:@"First" forState:UIControlStateNormal];
    [rightBtn setTitle:@"First" forState:UIControlStateSelected];
    [rightBtn setTitle:@"First" forState:UIControlStateHighlighted];
    [rightBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [rightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [rightBtn addTarget:self
                 action:@selector(clickDoneBtn:)
       forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)clickDoneBtn:(UIButton *)button
{
    NSLog(@"%s clickDoneBtn.", __FILE__);
}

@end
