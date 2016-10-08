//
//  PopViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/10/7.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "PopViewController.h"

@interface PopViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *redView;


@end

@implementation PopViewController

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
- (IBAction)onClickPlayBtn:(id)sender
{
    static BOOL changed = NO;
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    
    if (changed) {
        scaleAnimation.toValue = [UIColor redColor];
        scaleAnimation.springBounciness = 10.0f;
        scaleAnimation.springSpeed = 20;
        
        changed = NO;
    } else {
        scaleAnimation.toValue = [UIColor yellowColor];
        scaleAnimation.springBounciness = 10.0f;
        scaleAnimation.springSpeed = 20;
        
        changed = YES;
    }
    
    
//    [self.button.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnim"];
    
    [self.redView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnim"];
    
    
    
}

@end
