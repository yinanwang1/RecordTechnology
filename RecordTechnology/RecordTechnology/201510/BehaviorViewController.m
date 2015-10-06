//
//  BehaviorViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/10/5.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "BehaviorViewController.h"

@interface BehaviorViewController ()

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, strong) UIView *view0;
@property (nonatomic, strong) UIView *view1;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation BehaviorViewController

@synthesize view0, view1, dynamicAnimator;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    view0 = [[UIView alloc] initWithFrame:CGRectMake(50, 50,50, 50)];
    view0.backgroundColor = [UIColor purpleColor];
    
    [self.view addSubview:view0];
    
    
    view1 = [[UIView alloc] initWithFrame:CGRectMake(150, 150,50, 50)];
    view1.backgroundColor = [UIColor colorWithRed:0.300 green:0.334 blue:0.768 alpha:1.000];
    
    [self.view addSubview:view1];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1
//                                                  target:self
//                                                selector:@selector(printViewFrame)
//                                                userInfo:nil
//                                                 repeats:YES];
    

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

- (void)printViewFrame
{
    NSLog(@"view0's frame is %@", NSStringFromCGRect(self.view0.frame));
}

- (void)tapAction:(UITapGestureRecognizer *)sender
{
#pragma mark 推动效果
//        [dynamicAnimator removeAllBehaviors];
//         UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[view0] mode:UIPushBehaviorModeContinuous];
//     //    x是正右  负左  y是正下  负上
//         push.pushDirection = CGVectorMake(1, 0);
//         push.magnitude = 5;
//         push.active = YES;
//         push.angle = 0.5;
//         [dynamicAnimator addBehavior:push];
#pragma mark 迅速移动效果
//    [dynamicAnimator removeAllBehaviors];
//     UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:view0 snapToPoint:[sender locationInView:self.view]];
//     snap.damping = 0.0; // 阻尼值从0.0到1.0。0.0是最低的振荡
//     [dynamicAnimator addBehavior:snap];
#pragma mark 吸符效果(吸符一个点)
    [self.dynamicAnimator removeAllBehaviors];
    UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:view0 offsetFromCenter:UIOffsetMake(20, 20) attachedToAnchor:[sender locationInView:self.view]];
    attachment.length = 100;
    attachment.damping = 0.5;
    attachment.frequency = 50;
    [self.dynamicAnimator addBehavior:attachment];
#pragma mark  吸符效果(吸符一个视图)
        UIAttachmentBehavior *attachment1 = [[UIAttachmentBehavior alloc] initWithItem:view0 offsetFromCenter:UIOffsetMake(10, 10) attachedToItem:view1 offsetFromCenter:UIOffsetMake(10, 10)];
        attachment1.length = 100;
        attachment1.damping = 0.5;
        attachment1.frequency = 50;
        [dynamicAnimator addBehavior:attachment1];
    
    UIAttachmentBehavior *attachment2 = [[UIAttachmentBehavior alloc] initWithItem:view1 attachedToItem:view0];
    attachment2.damping = 0.5;
    attachment2.frequency = 50;
    [self.dynamicAnimator addBehavior:attachment2];
    
}

@end
