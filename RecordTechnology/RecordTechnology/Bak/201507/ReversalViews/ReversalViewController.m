//
//  ReversalViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/7/31.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "ReversalViewController.h"

@interface ReversalViewController ()

@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;


@end

@implementation ReversalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.image1.image = [UIImage imageNamed:@"ReversalImage1"];
    self.image2.image = [UIImage imageNamed:@"ReversalImage2"];
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


- (IBAction)changeImages:(id)sender
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_parentView cache:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:_parentView cache:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:_parentView cache:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:_parentView cache:YES];
    
    NSInteger purple = [[_parentView subviews] indexOfObject:self.image1];
    NSInteger maroon = [[_parentView subviews] indexOfObject:self.image2];
    
    [_parentView exchangeSubviewAtIndex:purple withSubviewAtIndex:maroon];
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
    
}



@end
