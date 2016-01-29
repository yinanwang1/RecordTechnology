//
//  PushDismissAnimator.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/1/29.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "PushDismissAnimator.h"

@interface PushDismissAnimator ()

@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;

@property (nonatomic, weak) UIViewController *fromViewController;
@property (nonatomic, weak) UIViewController *toViewController;
@property (nonatomic, weak) UIView           *containerView;

@end

@implementation PushDismissAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.containerView = [transitionContext containerView];
    self.transitionContext = transitionContext;
    
    UIView *currentView = self.fromViewController.view;
    
    UIView *toView = self.toViewController.view;
    toView.transform = CGAffineTransformMakeScale(0.98f, 0.98f);
    
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:1.0f
                          delay:0.0f
         usingSpringWithDamping:1.0f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         currentView.y = [UIScreen mainScreen].bounds.size.height;
                         toView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                     } completion:^(BOOL finished) {
                         [weakSelf.transitionContext completeTransition:![weakSelf.transitionContext transitionWasCancelled]];
                     }];
}

@end
