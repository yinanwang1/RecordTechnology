//
//  YouFireViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/20.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "YouFireViewController.h"

#import "YouFireTableViewCell.h"
#import "ModuleListViewController.h"
#import "EditingViewController.h"

#import "WebService.h"

static NSString * youFireTableViewCell = @"YouFireTableViewCell";
static NSString * editingVCIdentifier = @"showEditingView";

@interface YouFireViewController () <UITableViewDataSource, UITableViewDelegate, ModuleListViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *youFireTableView;

@property (nonatomic, strong) ModuleListViewController *moduleListVC;

@end

@implementation YouFireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"你火了";
    
    [self.youFireTableView registerNib:[UINib nibWithNibName:youFireTableViewCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:youFireTableViewCell];
    
    // Test new AFNetworking 2.0
    [self networkWithAFNEtworking2_0];
}

- (void)networkWithAFNEtworking2_0
{
    // location=北京&output=json&ak=5slgyqGDENN7Sy7pw29IUvrZ
    [WebService sharedClient:@"http://api.map.baidu.com/telematics/v3"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"北京", @"location",
                         @"json", @"output",
                         @"5slgyqGDENN7Sy7pw29IUvrZ", @"ak", nil];
    
    [WebService getRequest:@"weather" parameters:dic
                  encToken:nil
                   isLogin:YES
                   success:^(id JSON) {
                       NSLog(@"JSON is %@.", JSON);
                   } failure:^(NSError *error, id JSON) {
                       NSLog(@"error is %@.", error);
                   }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    UIViewController *viewController = segue.destinationViewController;
    if ( [viewController isKindOfClass:[EditingViewController class]] )
    {
        EditingViewController *vc = (EditingViewController *)viewController;
        vc.firstStyleStr = (NSString *)sender;
    }
}


#pragma mark - targets methods

- (IBAction)createNewProduct:(id)sender {
    
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

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:youFireTableViewCell];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}




#pragma mark -- ModuleListViewControllerDelegate

- (void)hasSelectedStyle:(NSString *)styleNameStr
{
    [self performSegueWithIdentifier:editingVCIdentifier sender:styleNameStr];
}


@end
