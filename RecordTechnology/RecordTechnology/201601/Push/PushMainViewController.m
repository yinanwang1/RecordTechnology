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

#import "Masonry.h"

@interface PushMainViewController () <UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning>

@property (nonatomic, strong) PushFirstViewController *firstVC;

@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation PushMainViewController

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
     self.firstVC = [[PushFirstViewController alloc] initWithNibName:@"PushFirstViewController" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:self.firstVC animated:YES];
}

- (IBAction)onClickSecondBtn:(id)sender
{
    PushSecondViewController *secondVC = [[PushSecondViewController alloc] initWithNibName:@"PushSecondViewController" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:secondVC animated:YES];
}


#pragma mark - UINavigationControllerDelegate

//- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
//{
//    return [[UIPercentDrivenInteractiveTransition alloc] init];
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
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    
    [toVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(containerView);
    }];
    
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
