//
//  MyTabBarViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/7/12.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "MyTabBarViewController.h"

#import "MyTabBarView.h"

@interface MyTabBarViewController () <MyTabBarViewDelegate>

@end

@implementation MyTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = self.tabBar.bounds;
    
    MyTabBarView *tabBarView = [[MyTabBarView alloc] init];
    tabBarView.delegate = self;
    tabBarView.frame = rect;
    
    [self.tabBar addSubview:tabBarView];
    
    for (int i=0; i < [self.viewControllers count]; i++) { //根据有多少个子视图控制器来进行添加按钮
        
        NSString *imageName = [NSString stringWithFormat:@"tabbar%d_normal", i + 1];
        NSString *imageNameSel = [NSString stringWithFormat:@"tabbar%d_selected", i + 1];
        
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *imageSel = [UIImage imageNamed:imageNameSel];
        
        [tabBarView addButtonWithImage:image selectdImage:imageSel];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - MyTabBarViewDelegate

- (void)tabBar:(MyTabBarView *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}

@end
