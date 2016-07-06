//
//  MasonryViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/7/1.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "MasonryViewController.h"

@interface MasonryViewController ()

@end

@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor redColor];
    
    self.navigationController.navigationBar.hidden = YES;
    
    
    [self masonry2];
    
    
    
    
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

- (void)masonry1
{
    UIView *sv = [[UIView alloc] init];
    
    sv.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:sv];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(padding);
    }];
}


// 居中显示
- (void)masonry2
{
    UIView *myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:myView];
    
    
    [myView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
}


@end
