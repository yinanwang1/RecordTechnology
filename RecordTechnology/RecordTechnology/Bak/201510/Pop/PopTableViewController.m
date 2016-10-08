//
//  PopTableViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2016/10/7.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "PopTableViewController.h"

@interface PopTableViewController ()

@end

@implementation PopTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static BOOL changed = NO;
//    
//    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
//    
//    if (changed) {
//        scaleAnimation.toValue = [UIColor redColor];
//        scaleAnimation.springBounciness = 10.0f;
//        scaleAnimation.springSpeed = 20;
//        
//        changed = NO;
//    } else {
//        scaleAnimation.toValue = [UIColor yellowColor];
//        scaleAnimation.springBounciness = 10.0f;
//        scaleAnimation.springSpeed = 20;
//        
//        changed = YES;
//    }
//    
//    [cell.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnim"];
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *cellsArr = self.tableView.visibleCells;
    
    for (UITableViewCell *cell in cellsArr) {
        static BOOL changed = NO;
        
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
        
        if (changed) {
            scaleAnimation.toValue = [UIColor redColor];
            scaleAnimation.springBounciness = 10.0f;
            scaleAnimation.springSpeed = 12;
            
            changed = NO;
        } else {
            scaleAnimation.toValue = [UIColor yellowColor];
            scaleAnimation.springBounciness = 10.0f;
            scaleAnimation.springSpeed = 12;
            
            changed = YES;
        }
        
        [cell.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnim"];
    }
}


@end
