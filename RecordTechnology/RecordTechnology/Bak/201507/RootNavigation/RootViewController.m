//
//  RootViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/7/18.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavigationBarStatus];
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

- (void)initNavigationBarStatus
{
    [self addLeftBarButtonItem];
    
    [self addRightBarButtonItem];
    
    [self addTitleView];
    
}

- (void)addLeftBarButtonItem
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:BAR_BUTTON_ITEM_FRAME];
    [leftBtn setTitle:@"Back" forState:UIControlStateNormal];
    [leftBtn setTitle:@"Back" forState:UIControlStateSelected];
    [leftBtn setTitle:@"Back" forState:UIControlStateHighlighted];
    [leftBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [leftBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [leftBtn addTarget:self
                action:@selector(clickBackBtn:)
      forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)addRightBarButtonItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:BAR_BUTTON_ITEM_FRAME];
    [rightBtn setTitle:@"Done" forState:UIControlStateNormal];
    [rightBtn setTitle:@"Done" forState:UIControlStateSelected];
    [rightBtn setTitle:@"Done" forState:UIControlStateHighlighted];
    [rightBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [rightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [rightBtn addTarget:self
                 action:@selector(clickDoneBtn:)
       forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)addTitleView
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:BAR_TITLE_ITEM_FRAME];
    [titleLabel setTextColor:[UIColor redColor]];
    [titleLabel setText:@"Sign In"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    self.navigationItem.titleView = titleLabel;
}



#pragma mark - Target Methods

- (void)clickBackBtn:(UIButton *)button
{
    NSLog(@"%s clickBackBtn.", __FILE__);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickDoneBtn:(UIButton *)button
{
    NSLog(@"%s clickDoneBtn.", __FILE__);
}


@end
