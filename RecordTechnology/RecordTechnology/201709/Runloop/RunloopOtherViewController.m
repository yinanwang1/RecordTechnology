//
//  RunloopOtherViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/9/22.
//  Copyright © 2017年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "RunloopOtherViewController.h"

@interface RunloopOtherViewController () <UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching,UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation RunloopOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;

    self.navigationItem.title = @"一点都不大";

    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tst"];

    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.delegate = self;
    searchController.searchResultsUpdater = self;
    searchController.searchBar.delegate = self;

    searchController.searchBar.placeholder = @"自定义默认值的颜色";

    //    [searchController.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"ic_lingshihe_normal"] forState:UIControlStateNormal];

    searchController.searchBar.barStyle = UIBarStyleBlackTranslucent;


    self.navigationItem.searchController = searchController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching

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

    cell.textLabel.text = @"很大的弄";

    return cell;
}

- (void)tableView:(UITableView *)tableView prefetchRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    NSLog(@"indexPaths is %@.", indexPaths);
}


#pragma mark - UISearchControllerDelegate


#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"searchController is %@.", searchController);
}


#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar                      // return NO to not become first responder
{
    NSLog(@"searchBarShouldBeginEditing");

    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;                     // called when text starts editing
{
    NSLog(@"searchBarTextDidBeginEditing");
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar;                        // return NO to not resign first responder
{
    NSLog(@"searchBarShouldEndEditing");

    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;                       // called when text ends editing
{
    NSLog(@"searchBarTextDidEndEditing");

}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)
{
    NSLog(@"searchBar:textDidChange: is %@.", searchText);
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0); // called before text changes
{
    NSLog(@"searchBar:shouldChangeTextInRange:replacementText: is %@", text);

    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;                     // called when keyboard search button pressed
{
    NSLog(@"searchBarSearchButtonClicked");
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED; // called when bookmark button pressed
{
    NSLog(@"searchBarBookmarkButtonClicked");
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED;   // called when cancel button pressed
{
    NSLog(@"searchBarCancelButtonClicked");
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED; // called when search results button pressed
{
    NSLog(@"searchBarResultsListButtonClicked:");
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope NS_AVAILABLE_IOS(3_0);
{
    NSLog(@"selectedScopeButtonIndexDidChange:");
}

@end
