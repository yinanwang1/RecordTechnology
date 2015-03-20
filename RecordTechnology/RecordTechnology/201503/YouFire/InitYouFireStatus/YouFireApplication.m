//
//  YouFireApplication.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/20.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "YouFireApplication.h"

#import "AppDelegate.h"

static YouFireApplication *staticYouFireApplication = nil;

@implementation YouFireApplication

+ (id)shareYouFireApplication
{
    if ( nil == staticYouFireApplication )
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
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
            
        });
    }
    
    return staticYouFireApplication;
}

@end
