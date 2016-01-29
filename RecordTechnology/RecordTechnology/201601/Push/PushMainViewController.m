//
//  MainViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/1/29.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "PushMainViewController.h"

#import "PushFirstViewController.h"
#import "PushSecondViewController.h"

@interface PushMainViewController () <UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning>

@end

@implementation PushMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.delegate = self;
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

#pragma mark - Target Methods


- (IBAction)onClickFirstBtn:(id)sender
{
    PushFirstViewController *firstVC = [[PushFirstViewController alloc] initWithNibName:@"PushFirstViewController" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:firstVC animated:YES];
}

- (IBAction)onClickSecondBtn:(id)sender
{
    PushSecondViewController *secondVC = [[PushSecondViewController alloc] initWithNibName:@"PushSecondViewController" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:secondVC animated:YES];
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
    return 1.0f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    
    toVC.view.alpha = 0.0f;
    
    [UIView animateWithDuration:1.0f
                          delay:0.0f
         usingSpringWithDamping:1
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         fromVC.view.alpha = 0.0f;
                         toVC.view.alpha = 1.0f;
                     } completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark - UIViewControllerInteractiveTransitioning

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSLog(@"What to do!");
}


@end
