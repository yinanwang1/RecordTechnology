//
//  PopViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2018/4/25.
//  Copyright © 2018年 Monkey King. All rights reserved.
//

#import "PopViewController.h"

#import <pop/POP.h>

@interface PopViewController () <CALayerDelegate, CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIButton *myButton;

@property (nonatomic, strong) CALayer *firstLayer;


@end

@implementation PopViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [self pauseLayer:self.firstLayer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self resumeLayer:self.firstLayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // layer
    CALayer *layer        = [CALayer layer];
    layer.frame           = CGRectMake(100, 100, 3, 3);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.delegate        = self;
    [self.view.layer addSublayer:layer];

    // 动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animation.fromValue         = [NSValue valueWithCGRect:layer.frame];
    animation.toValue           = [NSValue valueWithCGRect:CGRectMake(100, 100, 100, 300)];
    animation.duration          = 30.f;
    animation.delegate          = self;                   // 设置代理

    
    [layer addAnimation:animation forKey:@"YouXianMing"]; // 添加动画

    self.firstLayer = layer;

//    // 暂停动画
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self pauseLayer:layer];
//    });
//
//    // 恢复动画
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self resumeLayer:layer];
//    });
//
//    // 移除动画(根据key值)
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [layer removeAnimationForKey:@"YouXianMing"];
//    });

}

/**
 *  动画确实停止了
 *
 *  @param anim CAAnimation对象
 *  @param flag 是否是正常的移除
 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"动画:%@ 是否动画中途被移除了:%d", anim, flag);
}

/**
 *  暂停
 *
 *  @param layer 被停止的layer
 */
-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed               = 0.0;
    layer.timeOffset          = pausedTime;
}

/**
 *  恢复
 *
 *  @param layer 被恢复的layer
 */
-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime     = [layer timeOffset];
    layer.speed                   = 1.0;
    layer.timeOffset              = 0.0;
    layer.beginTime               = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime               = timeSincePause;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animation
{
    DLog(@"333");

    CGRect frame = self.myButton.frame;

    frame.origin.y -= 10;

    [UIView animateWithDuration:1 animations:^{
        self.myButton.frame = frame;
    }];
}

- (IBAction)onClickMyBtn:(id)sender
{
    DLog(@"222");

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onClickPopBtn:(id)sender
{


}

@end
