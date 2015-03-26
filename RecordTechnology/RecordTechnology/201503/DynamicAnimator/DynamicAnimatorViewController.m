//
//  DynamicAnimatorViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/26.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "DynamicAnimatorViewController.h"

#import "DynamicAnimatorView.h"

@interface DynamicAnimatorViewController ()

@property (weak, nonatomic) IBOutlet DynamicAnimatorView *blockView;

@property (nonatomic, assign) BOOL animating;

@end

@implementation DynamicAnimatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)start:(id)sender {
    
    if (self.animating) {
        return;
    }
    
    self.animating = YES;
    
    CGFloat from = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.blockView.bounds) / 2;
    CGFloat to = 100;
    
    self.blockView.center = CGPointMake(self.blockView.center.x, from);
    
    [self.blockView startAnimationFrom:from to:to];
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:0 options:0 animations:^{
        self.blockView.center = CGPointMake(self.blockView.center.x, to);
    } completion:^(BOOL finished) {
        [self.blockView completeAnimation];
        self.animating = NO;
    }];
    
}





@end
