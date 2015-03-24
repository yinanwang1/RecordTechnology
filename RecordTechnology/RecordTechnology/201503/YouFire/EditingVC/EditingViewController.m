//
//  EditingViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/20.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "EditingViewController.h"

#import "iCarousel.h"

#import "AllEffectInstance.h"
#import "ModuleListViewController.h"


#pragma GCC diagnostic ignored "-Wgnu"


@interface EditingViewController () <iCarouselDataSource, iCarouselDelegate, ModuleListViewControllerDelegate>

@property (weak, nonatomic) IBOutlet iCarousel *carousel;


@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, strong) AllEffectInstance *allEffectInstance;

@property (nonatomic, strong) ModuleListViewController *moduleListVC;

@end

@implementation EditingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setUp];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCarouselView];
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

#pragma mark - Init Carousel view

- (void)setUp
{
    //set up data
    self.wrap = NO;
    self.items = [[NSMutableArray alloc] initWithCapacity:5];
    
    _allEffectInstance = [[AllEffectInstance alloc] init];
    
    
}

- (void)initCarouselView
{
    //configure carousel
    self.carousel.type = iCarouselTypeCoverFlow2;
    
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    
    [self.items addObject:self.firstStyleStr];
    
    [self.carousel reloadData];

}


#pragma mark - iCarouselDataSource, iCarouselDelegate

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    return (NSInteger)[self.items count];
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIView *effectView = [self.allEffectInstance createEffectVCInstanceWithName:[self.items objectAtIndex:index]];
    
    if ( nil == view )
    {
        CGFloat width = carousel.frame.size.width * 0.8;
        CGFloat height = carousel.frame.size.height * 0.8;
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        view.contentMode = UIViewContentModeCenter;
    }
    
    [effectView setFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    
    for (UIView *subview in view.subviews) {
        [subview removeFromSuperview];
    }
    
    [view addSubview:effectView];
    
    return view;
}


- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.carousel.itemWidth);
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return self.wrap;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}

#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    if ( index >= 0 && index < [self.items count] )
    {
        NSNumber *item = [self.items objectAtIndex:index];

        NSLog(@"Tapped view number: %@", item);
    }
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
    NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
}


#pragma mark -- target methods

- (IBAction)addNewEffect:(id)sender {
    if ( nil == _moduleListVC )
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"YouFire" bundle:[NSBundle mainBundle]];
        _moduleListVC = [storyboard instantiateViewControllerWithIdentifier:@"ModuleListViewController"];
        _moduleListVC.moduleListDelegate = self;
        _moduleListVC.title = @"选择一页";
    }
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.moduleListVC];
    
    [self presentViewController:nav
                       animated:YES completion:^{
                           NSLog(@"finish.");
                       }];
    
}

#pragma mark -- ModuleListViewControllerDelegate

- (void)hasSelectedStyle:(NSString *)styleNameStr
{
    NSLog(@"%s", __func__);
    
    [self.items addObject:styleNameStr];
    
    [self.carousel insertItemAtIndex:[self.items count] animated:YES];
    
    [self.carousel scrollByNumberOfItems:[self.items count] duration:1];
}




@end
