//
//  PushFirstViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/1/29.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "PushFirstViewController.h"

@interface PushFirstViewController () <UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning>

@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation PushFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Target Methods

- (IBAction)onClickPOPBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onClickOutSide:(id)sender
{
    NSLog(@"Outside Outside!!!");
}



#pragma mark - UINavigationControllerDelegate

//- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
//{
//    return self;
//}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return self;
}


#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 3.0f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.transitionContext = transitionContext;
    
    [[self.transitionContext containerView] addSubview:toVC.view];
    
    toVC.view.alpha = 0.0f;
    
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:3.0f
                          delay:0.0f
         usingSpringWithDamping:1
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^{
                         fromVC.view.alpha = 0.0f;
                         toVC.view.alpha = 1.0f;
                     } completion:^(BOOL finished) {
                         [weakSelf.transitionContext completeTransition:YES];
                     }];
}

- (void)animationEnded:(BOOL)transitionCompleted
{
    [self.transitionContext completeTransition:YES];
}

#pragma mark - UIViewControllerInteractiveTransitioning

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSLog(@"What to do!");
}

@end
