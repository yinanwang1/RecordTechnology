//
//  PushSecondViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/1/29.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "PushSecondViewController.h"

#import "PushAnimator.h"
#import "PushDismissAnimator.h"
#import "PushThirdViewController.h"

@interface PushSecondViewController () <UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;
@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;

@property (nonatomic, strong) PushThirdViewController *pushThirdVC;

@end

@implementation PushSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIScreenEdgePanGestureRecognizer *edge = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(edgePanGesture:)];
    
    edge.edges = UIRectEdgeLeft;
    
    [self.view addGestureRecognizer:edge];
    
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

/*
 用来控制这个滑动百分比
 */
- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        
        [self.navigationController popViewControllerAnimated:YES];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateCancelled
               || recognizer.state == UIGestureRecognizerStateEnded) {
        if (progress > 0.5) {
            [self.percentDrivenTransition finishInteractiveTransition];
        } else {
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
        
        self.percentDrivenTransition = nil;
    }
}


#pragma mark - Setter Getter Methods

- (PushThirdViewController *)pushThirdVC
{
    if (nil == _pushThirdVC) {
        _pushThirdVC = [[PushThirdViewController alloc] init];
        _pushThirdVC.transitioningDelegate = self;
        _pushThirdVC.modalPresentationStyle = UIModalPresentationCustom;
    }
    
    return _pushThirdVC;
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

- (IBAction)onClickPresentBtn:(id)sender
{
    [self presentViewController:self.pushThirdVC
                       animated:YES
                     completion:^{
                         // DO
                     }];
}



#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.percentDrivenTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    return self;
}


#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.transitionContext = transitionContext;
    
    [[self.transitionContext containerView] addSubview:toVC.view];
    
    toVC.view.alpha = 0.0f;
    
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.5f
                          delay:0.0f
         usingSpringWithDamping:1
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^{
                         fromVC.view.alpha = 0.0f;
                         toVC.view.alpha = 1.0f;
                     } completion:^(BOOL finished) {
                         [weakSelf.transitionContext completeTransition:![weakSelf.transitionContext transitionWasCancelled]];
                     }];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[PushAnimator alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[PushDismissAnimator alloc] init];
}


@end
