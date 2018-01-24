//
//  HXSBaseNavigationController.m
//  store
//
//  Created by chsasaw on 14-10-15.
//  Copyright (c) 2014年 huanxiao. All rights reserved.
//

#import "HXSBaseNavigationController.h"

@interface HXSBaseNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation HXSBaseNavigationController

#pragma mark - Controller Lifecycel

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.delegate = self;
        self.interactivePopGestureRecognizer.delegate = self;
    }
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = (navigationController.viewControllers.count >= 2);
    }

    BOOL enable = navigationController.viewControllers.count <= 1;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"123" object:nil userInfo:@{@"123":@(enable)}];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)] &&
        gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
        return NO;
    }
    return YES;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    viewController.hidesBottomBarWhenPushed = YES;
    
    [super pushViewController:viewController animated:animated];
    
}


#pragma mark - UIViewController Overwirte Methods

-(BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

- (BOOL)prefersStatusBarHidden
{
    return [self.topViewController prefersStatusBarHidden];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationFade;
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

- (BOOL)disablesAutomaticKeyboardDismissal
{
    return [self.topViewController disablesAutomaticKeyboardDismissal];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


@end
