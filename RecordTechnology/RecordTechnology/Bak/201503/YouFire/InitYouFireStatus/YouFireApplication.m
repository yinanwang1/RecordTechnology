//
//  YouFireApplication.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/20.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "YouFireApplication.h"

#import "AppDelegate.h"
#import "WWSideslipViewController.h"

static YouFireApplication *staticYouFireApplication = nil;

@implementation YouFireApplication

+ (id)shareYouFireApplication
{
    if ( nil == staticYouFireApplication )
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            // 侧滑   像“网易新闻”
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YouFire" bundle:[NSBundle mainBundle]];
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            MFSideMenuContainerViewController *containerVC = (MFSideMenuContainerViewController *)delegate.window.rootViewController;
            
            UIViewController *centerVC = [storyboard instantiateViewControllerWithIdentifier:@"YouFireViewController"];
            UIViewController *leftVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftSideViewController"];
            UIViewController *rightVC = [storyboard instantiateViewControllerWithIdentifier:@"RightSideViewController"];
            
            UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:centerVC];
            
            containerVC.centerViewController = navigationVC;
            containerVC.leftMenuViewController = leftVC;
            containerVC.rightMenuViewController = rightVC;
            
            
            // 侧滑  像“QQ”
            /*
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YouFire" bundle:[NSBundle mainBundle]];
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            WWSideslipViewController *containerVC = (WWSideslipViewController *)delegate.window.rootViewController;
            
            UIViewController *centerVC = [storyboard instantiateViewControllerWithIdentifier:@"YouFireViewController"];
            UIViewController *leftVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftSideViewController"];
            UIViewController *rightVC = [storyboard instantiateViewControllerWithIdentifier:@"RightSideViewController"];
            
            UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:centerVC];
            
            containerVC = [containerVC initWithLeftView:leftVC andMainView:navigationVC andRightView:rightVC andBackgroundImage:[UIImage imageNamed:@"bg"]];
             */
            
        });
    }
    
    return staticYouFireApplication;
}

@end
