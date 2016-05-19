//
//  TwoScrollViewViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/5/18.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "TwoScrollViewViewController.h"

@interface TwoScrollViewViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation TwoScrollViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tst"];
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

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tst" forIndexPath:indexPath];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tst"];
    }
    
    cell.textLabel.text = @"这个是测试用的";
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (0 < scrollView.contentOffset.y) {
        [UIView animateWithDuration:0.5
                         animations:^{
                             [self.scrollView setContentOffset:CGPointMake(0, 100)];
                         }];
    }
    else {
        [UIView animateWithDuration:0.5
                         animations:^{
                             [self.scrollView setContentOffset:CGPointMake(0, 0)];
                         }];
    }
}

@end
