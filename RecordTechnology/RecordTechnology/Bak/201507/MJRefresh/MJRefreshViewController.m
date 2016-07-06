//
//  MJRefreshViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/7/1.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "MJRefreshViewController.h"

@interface MJRefreshViewController () <UITableViewDataSource, UITableViewDelegate>
{
    CGRect _rect;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableViewData;


@end

@implementation MJRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ( nil ==  _tableViewData )
    {
        _tableViewData = [[NSMutableArray alloc] initWithCapacity:5];
    }
    
    for (int i=0; i < 5; i++)
    {
        [self.tableViewData addObject:[NSString stringWithFormat:@"这是第%d条。", i+1]];
    }
    
    
    [self setupRefresh];
    
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


- (void)setupRefresh
{
//    [self example1];
    
//    [self example2];
    
//    [self example3];
    
    [self example4];
    
}

- (void)example1
{
    // 下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableViewData insertObject:[NSString stringWithFormat:@"这是刷新的数据"] atIndex:0];
        
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
        
    }];
}

- (void)example2
{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{

        [self.tableViewData insertObject:[NSString stringWithFormat:@"这是刷新的数据"] atIndex:0];
        
        
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
    }];
    
    NSMutableArray *idle = [[NSMutableArray alloc] initWithCapacity:5];
    NSMutableArray *pulling = [[NSMutableArray alloc] initWithCapacity:5];
    NSMutableArray *refreshing = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i = 1; i < 2; i++)
    {
        NSString *idleImageName = [NSString stringWithFormat:@"%d", i];
        [idle addObject:[UIImage imageNamed:@"haizeiwang"]];
        
        NSString *pullImageName = [NSString stringWithFormat:@"%d", i + 8];
        [pulling addObject:[UIImage imageNamed:@"haizeiwang"]];
        
        NSString *refreshImageName = [NSString stringWithFormat:@"%d", i + 16];
        [refreshing addObject:[UIImage imageNamed:@"haizeiwang"]];
    }
    
    [header setImages:idle forState:MJRefreshStateIdle];
    
    [header setImages:pulling forState:MJRefreshStatePulling];
    
    [header setImages:refreshing forState:MJRefreshStateRefreshing];
    
    
    self.tableView.header = header;
}


- (void)example3
{
    // 下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableViewData insertObject:[NSString stringWithFormat:@"这是刷新的数据"] atIndex:0];
        
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
        
    }];
    
    MJRefreshStateHeader *header = (MJRefreshStateHeader *)self.tableView.header;
    header.lastUpdatedTimeLabel.hidden = YES;
}

- (void)example4
{
    // 下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableViewData insertObject:[NSString stringWithFormat:@"这是刷新的数据"] atIndex:0];
        
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
        
    }];
    
    MJRefreshStateHeader *header = (MJRefreshStateHeader *)self.tableView.header;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
}


#pragma mark -- UITableView UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableViewData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.textLabel.text = [self.tableViewData objectAtIndex:indexPath.row];

    
    return cell;
}



@end
