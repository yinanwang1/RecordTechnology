//
//  DefineTabBarViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/12/30.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "DefineTabBarViewController.h"

#import "DefineTabBar.h"
#import "DefineButton.h"

@interface DefineTabBarViewController () <DefineBarDelegate>

@end

@implementation DefineTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];

    CGRect rect = self.tabBar.bounds;
    
    DefineTabBar *defineTabBar = [[DefineTabBar alloc] init];
    defineTabBar.tabBarDelegate = self;
    defineTabBar.frame = rect;
    [self.tabBar addSubview:defineTabBar];
    
    for (int i = 0; i < [self.viewControllers count]; i++) {
        NSString *normalImageStr = [NSString stringWithFormat:@"tabbar%d_normal", i + 1];
        NSString *selectedImageStr = [NSString stringWithFormat:@"tabbar%d_selected", i + 1];
        
        UIImage *normalImage = [UIImage imageNamed:normalImageStr];
        UIImage *selectedImage = [UIImage imageNamed:selectedImageStr];
        
        [defineTabBar addButtonWithNormalImage:normalImage selectedImage:selectedImage];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - DefineBarDelegate

- (void)tabBar:(DefineTabBar *)tabBar selectedForm:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}

@end
