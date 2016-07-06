//
//  MLeaksFinder1ViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/7/6.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "MLeaksFinder1ViewController.h"

static NSString * const cellIdentifier = @"cellIdentifier";

@interface MLeaksFinder1ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation MLeaksFinder1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableview registerClass:[UITableViewCell class]
           forCellReuseIdentifier:cellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"%@", NSStringFromClass([self class]));
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = @"真的是很长很长的样子啊啊啊啊 啊啊啊啊";
    
    
    return cell;
}

@end
