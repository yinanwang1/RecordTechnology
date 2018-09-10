//
//  AnimatedNavigationViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2018/9/7.
//  Copyright © 2018年 Monkey King. All rights reserved.
//

#import "AnimatedNavigationViewController.h"

@interface AnimatedNavigationViewController ()

@end

@implementation AnimatedNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        if (animated) {

            CATransition *animation = [CATransition animation];
            animation.duration = 0.4f;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.type = kCATransitionPush;
            animation.subtype = kCATransitionFromRight;
            [self.navigationController.view.layer addAnimation:animation forKey:nil];
            [self.view.layer addAnimation:animation forKey:nil];
            [super pushViewController:viewController animated:NO];
            return;
        }
    }
    [super pushViewController:viewController animated:animated];
}



@end
