//
//  AnimationViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/5/15.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation AnimationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.scrollView setContentSize:CGSizeMake(240, 1000)];
    
    NSMutableArray *mArr = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i = 1; i <= 45; i++) {
        NSString *imageNameStr = [NSString stringWithFormat:@"loading_%d", i];
        UIImage *image = [UIImage imageNamed:imageNameStr];
        
        [mArr addObject:image];
    }
    
    
    self.imageView.animationImages = mArr;
    self.imageView.animationDuration = 1.5f;
    self.imageView.animationRepeatCount = 0;
}

- (void)didReceiveMemoryWarning
{
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (45 > scrollView.contentOffset.y) {
        if ([self.imageView isAnimating]) {
            [self.imageView stopAnimating];
        }
        
        NSString *imageNameStr = [NSString stringWithFormat:@"loading_%d", (int)scrollView.contentOffset.y];
        [self.imageView setImage:[UIImage imageNamed:imageNameStr]];
        
        return;
    }
    
    [self.imageView startAnimating];
}

@end
