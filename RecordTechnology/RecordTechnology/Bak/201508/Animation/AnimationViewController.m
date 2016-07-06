//
//  AnimationViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/8/3.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *animationImageView;
@property (weak, nonatomic) IBOutlet UIButton *animationBtn;

@property (nonatomic, strong) UIImageView *gifImageView;
@property (nonatomic, strong) UIImageView *bigImageView;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initailBtnStatus];
    
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

#pragma mark - Initial Methods

- (void)initailBtnStatus
{
    [self.animationBtn setTitle:@"Normal" forState:UIControlStateNormal];
    [self.animationBtn setTitle:@"Highted" forState:UIControlStateHighlighted];
    [self.animationBtn setTitle:@"Selected" forState:UIControlStateSelected];
    
    [self.animationBtn addTarget:self
                          action:@selector(beginAnimationBtn:)
                forControlEvents:UIControlEventTouchDown];
    
}




#pragma mark - Target Methods

- (void)beginAnimationBtn:(UIButton *)button
{
    double durationValue = 1.0;
    
    if (nil == _gifImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        
        UIImage *image1 = [UIImage imageNamed:@"Animation1"];
        UIImage *image2 = [UIImage imageNamed:@"Animation2"];
        UIImage *image3 = [UIImage imageNamed:@"Animation3"];
        UIImage *image4 = [UIImage imageNamed:@"Animation4"];
        UIImage *image5 = [UIImage imageNamed:@"Animation5"];
        UIImage *image6 = [UIImage imageNamed:@"Animation6"];
        UIImage *image7 = [UIImage imageNamed:@"Animation7"];
        
        
        imageView.animationImages = @[image1, image2, image3, image4, image5, image6, image7];
        imageView.animationDuration = durationValue;
        imageView.animationRepeatCount = 1;
        imageView.center = button.center;
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(clickGifAnimation:)];
        [imageView addGestureRecognizer:tap];
        
        self.gifImageView = imageView;
    }
    
    [self.view addSubview:self.gifImageView];
    
    if (self.gifImageView.isAnimating) {
        [self.gifImageView stopAnimating];
    }
    
    [self.gifImageView startAnimating];
    
    [AnimationViewController cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopAnimation) object:nil];
    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:durationValue];
    
    
    
    if (nil == _bigImageView) {
        // big image change
        UIImageView *bigImageView = [[UIImageView alloc] initWithFrame:self.animationImageView.frame];
        bigImageView.image = self.animationImageView.image;
        bigImageView.contentMode = UIViewContentModeScaleAspectFit;
        bigImageView.backgroundColor = [UIColor clearColor];
        
        self.bigImageView = bigImageView;
        [self.view addSubview:self.bigImageView];
    }
    
    
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation1.fromValue = [NSValue valueWithCGPoint:self.bigImageView.center];
    CGPoint point =  (0 == button.center.x) ? self.gifImageView.center : button.center;
    animation1.toValue = [NSValue valueWithCGPoint:point];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation2.fromValue = [NSNumber numberWithFloat:0.0];
    animation2.toValue = [NSNumber numberWithFloat:4 * M_PI];
    
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation3.fromValue = [NSNumber numberWithFloat:1.0];
    animation3.toValue = [NSNumber numberWithFloat:0.5];
    
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation4.fromValue = [NSNumber numberWithFloat:1.0];
    animation4.toValue = [NSNumber numberWithFloat:0.3];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = durationValue;
    group.repeatCount = 1.0f;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = YES;
    group.animations = [NSArray arrayWithObjects:animation1, animation2, animation3, animation4, nil];
    
    [self.bigImageView.layer addAnimation:group forKey:@"move-rotate-layer"];

}


- (void)clickGifAnimation:(UITapGestureRecognizer *)gesture
{
    [self beginAnimationBtn:nil];
}

- (void)stopAnimation
{
    [self.gifImageView removeFromSuperview];
}


@end
