//
//  MainViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2018/1/23.
//  Copyright © 2018年 Monkey King. All rights reserved.
//

#import "MainViewController.h"

#import "LeftViewController.h"
#import "LeftTabBarViewController.h"

@interface MainViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (nonatomic, strong) LeftViewController *leftVC;
@property (nonatomic, strong) LeftTabBarViewController *leftTabBarVC;

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, assign) BOOL hasAddedMaskView;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.myScrollView.delegate = self;

    // 左边的VC
    [self addChildViewController:self.leftVC];
    [self.myScrollView addSubview:self.leftVC.view];
    [self.leftVC didMoveToParentViewController:self];

    [self.leftVC.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.myScrollView);
        make.width.mas_equalTo(ScreenWidth - 100);
        make.height.mas_equalTo(ScreenHeight);
    }];

    // TabBar
    [self addChildViewController:self.leftTabBarVC];
    [self.myScrollView addSubview:self.leftTabBarVC.view];
    [self.leftTabBarVC didMoveToParentViewController:self];

    [self.leftTabBarVC.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftVC.view.mas_right);
        make.top.bottom.right.equalTo(self.myScrollView);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(ScreenHeight);
    }];

    [self.myScrollView layoutIfNeeded];

    [self.myScrollView scrollRectToVisible:self.leftTabBarVC.view.frame animated:YES];


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateScrollViewEnabel:) name:@"123" object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updateScrollViewEnabel:(NSNotification *)notification
{
    NSNumber *enabel = [notification.userInfo objectForKey:@"123"];

    self.myScrollView.scrollEnabled = [enabel boolValue];
}



#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat maxWidth = ScreenWidth - 100;
    if (maxWidth > scrollView.contentOffset.x) {
        if (!self.hasAddedMaskView) {
            [self.leftTabBarVC.view addSubview:self.maskView];

            [self.maskView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.leftTabBarVC.view);
            }];
        }

        self.hasAddedMaskView = YES;

        self.maskView.alpha = (0.5 / maxWidth) * (maxWidth - scrollView.contentOffset.x);
    } else {
        [self.maskView removeFromSuperview];
        self.hasAddedMaskView = NO;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)hideSideBarVC
{
    [self.myScrollView scrollRectToVisible:self.leftTabBarVC.view.frame animated:YES];

    [UIView animateWithDuration:0.3
                     animations:^{
                         self.maskView.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [self.maskView removeFromSuperview];
                         self.hasAddedMaskView = NO;
                     }];
}


- (LeftViewController *)leftVC
{
    if (nil == _leftVC) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LeftStoryboard" bundle:nil];
        _leftVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    }

    return _leftVC;
}

- (LeftTabBarViewController *)leftTabBarVC
{
    if (nil == _leftTabBarVC) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LeftStoryboard" bundle:nil];
        _leftTabBarVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftTabBarViewController"];
    }

    return _leftTabBarVC;
}

- (UIView *)maskView
{
    if (nil == _maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor blackColor];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSideBarVC)];

        [_maskView addGestureRecognizer:tap];
    }

    return _maskView;
}

@end








