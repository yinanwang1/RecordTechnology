//
//  HeaderViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/2/18.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "HeaderViewController.h"


static NSString *identifier = @"UITableViewCell";

#define HEIGHT_HEADER  130

@interface HeaderViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIView *headerView;

@end

@implementation HeaderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(HEIGHT_HEADER, 0, 0, 0)];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, HEIGHT_HEADER)];
    [view setBackgroundColor:[UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.5]];
    
    self.headerView = view;
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Animation1"]];
    [imageView setFrame:CGRectMake(0, 0, 600, HEIGHT_HEADER)];
    [imageView setContentMode:UIViewContentModeScaleToFill];
    
    [self.headerView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.headerView);
        make.height.equalTo(self.headerView).priority(750);
        make.height.mas_greaterThanOrEqualTo(HEIGHT_HEADER).priority(1000);
    }];
    
    [self.view addSubview:self.headerView];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.tableView);
        make.height.mas_equalTo(HEIGHT_HEADER);
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = @"Test This is a Test cell Test This is a Test cellTest This is a Test cellTest This is a Test cellTest This is a Test cellTest This is a Test cellTest This is a Test cellTest This is a Test cell";
    
    return cell;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollView.mj_offsetY is %f.", scrollView.mj_offsetY);
//    NSLog(@"self.headerView.frame is %@.", NSStringFromCGRect(self.headerView.frame));
    
    if (0.0 >= scrollView.mj_offsetY) {
        [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(fabs(scrollView.mj_offsetY));
        }];
    } else {
        [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    
}


@end
