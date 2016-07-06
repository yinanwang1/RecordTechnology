//
//  LeftSideViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/20.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "LeftSideViewController.h"

@interface LeftSideViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *usrNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *headPortraitBtn;
@property (weak, nonatomic) IBOutlet UITableView *functionTableView;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation LeftSideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataSource = @[@"意见反馈", @"关于我们", @"常见问题", @"清除缓存", @"修改密码", @"求好评", @"退出"];
    
    self.headPortraitBtn.layer.cornerRadius = 50.0f;
    [self.headPortraitBtn setBackgroundImage:[UIImage imageNamed:@"haizeiwang"] forState:UIControlStateNormal];
    [self.headPortraitBtn setTitle:@"" forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifierStr = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierStr];
    
    if ( nil == cell )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifierStr];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.textLabel.textColor = [UIColor orangeColor];
    }
    
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

@end
