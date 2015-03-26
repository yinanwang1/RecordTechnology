//
//  UIPageViewControllerTestViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/26.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "UIPageViewControllerTestViewController.h"

#import "MoreViewController.h"

@interface UIPageViewControllerTestViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) NSArray *pageContent;

@end

@implementation UIPageViewControllerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createContentPages];
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey:UIPageViewControllerOptionSpineLocationKey];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    
    self.pageController.delegate = self;
    self.pageController.dataSource = self;
    
    [self.pageController.view setFrame:self.view.bounds];
    
    MoreViewController *initialViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO completion:^(BOOL finished) {
                                       NSLog(@"Finish.");
                                   }];
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    
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


#pragma mark --  UIPageViewControllerDataSource, UIPageViewControllerDelegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(MoreViewController *)viewController];
    
    if ( NSNotFound == index )
    {
        return nil;
    }
    
    index++;
    
    if ( index == [self.pageContent count] )
    {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfViewController:(MoreViewController *)viewController];
    
    if ( (0 == index) || (index == NSNotFound) )
    {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

#pragma mark -- private methods

- (void)createContentPages
{
    NSMutableArray *pageStrings = [[NSMutableArray alloc] init];
    
    for (int i = 1; i < 11; i++)
    {
        NSString *contentString = [[NSString alloc] initWithFormat:@"Chapter %d This is the page %d of content displayed using UIPageViewController in iOS 5.", i, i];
        
        [pageStrings addObject:contentString];
    }
    
    self.pageContent = [[NSArray alloc] initWithArray:pageStrings];
}

- (MoreViewController *)viewControllerAtIndex:(NSInteger)index
{
    if ( (0 == [self.pageContent count])
        || (index >= [self.pageContent count]) )
    {
        return nil;
    }
    
    
    MoreViewController *moreVC = [[MoreViewController alloc] init];
    moreVC.dataObject = [self.pageContent objectAtIndex:index];
    
    
    return moreVC;
}

- (NSUInteger)indexOfViewController:(MoreViewController *)viewController
{
    return [self.pageContent indexOfObject:viewController.dataObject];
}






@end
