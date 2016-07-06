//
//  AtuomaticDimensionTableViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/8/8.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "AutomaticDimensionTableViewController.h"

#import "AutomaticDimensionTableViewCell.h"


#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface AutomaticDimensionTableViewController ()

@property (nonatomic, strong) NSMutableDictionary *offscreenCells;

@end

@implementation AutomaticDimensionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AutomaticDimensionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AutomaticDimensionTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableDictionary *)offscreenCells
{
    if (nil == _offscreenCells) {
        _offscreenCells = [[NSMutableDictionary alloc] initWithCapacity:5];
    }
    
    return _offscreenCells;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        
        AutomaticDimensionTableViewCell *cell = [self.offscreenCells objectForKey:@"AutomaticDimensionTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AutomaticDimensionTableViewCell" owner:self options:nil] lastObject];
            
            [self.offscreenCells setObject:cell forKey:@"AutomaticDimensionTableViewCell"];
        }
        
        // 填充内容
        cell.automaticDimensionlabel.text = @"要很长很长的哦。 哈啊哈 哈啊要很长很长的哦。 哈啊哈 哈啊要很长很长的哦。 哈啊哈 哈啊要很长很长的哦。 哈啊哈 哈啊要很长很长的哦。 哈啊哈 哈啊要很长很长的哦。 哈啊哈 哈啊要很长很长的哦。 哈啊哈 哈啊要很长很长的哦。 哈啊哈 哈啊要很长很长的哦。 哈啊哈 哈啊123456789012345678901234567890";
        
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        
        // 将cell的宽度设置为和tableView的宽度一样宽。
        // 这点很重要。
        // 如果cell的高度取决于table view的宽度（例如，多行的UILabel通过单词换行等方式），
        // 那么这使得对于不同宽度的table view，我们都可以基于其宽度而得到cell的正确高度。
        // 但是，我们不需要在-[tableView:cellForRowAtIndexPath]方法中做相同的处理，
        // 因为，cell被用到table view中时，这是自动完成的。
        // 也要注意，一些情况下，cell的最终宽度可能不等于table view的宽度。
        // 例如当table view的右边显示了section index的时候，必须要减去这个宽度。
        cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
        
        // 触发cell的布局过程，会基于布局约束计算所有视图的frame。
        // （注意，你必须要在cell的-[layoutSubviews]方法中给多行的UILabel设置好preferredMaxLayoutWidth值；
        // 或者在下面2行代码前手动设置！）
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        // 得到cell的contentView需要的真实高度
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        // 要为cell的分割线加上额外的1pt高度。因为分隔线是被加在cell底边和contentView底边之间的。
        height += 5.0f;
        
        return height;
    }else {
        return UITableViewAutomaticDimension;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AutomaticDimensionTableViewCell *cell = (AutomaticDimensionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AutomaticDimensionTableViewCell" forIndexPath:indexPath];
    
    cell.automaticDimensionlabel.text = @"要很长很长的哦。 哈啊哈 哈啊要很长很长的哦。 哈啊哈 哈啊要很长很长的哦。 哈啊哈 哈啊要很长很长的哦。 哈啊哈 哈啊要很长很长的哦。 哈啊哈 哈啊要很长很长的哦。 哈啊哈 哈啊要很长很长的哦。 哈啊哈 哈啊要很长很长的哦。 哈啊哈 哈啊要很长很长的哦。 哈啊哈 哈啊123456789012345678901234567890";
    
    
    
    return cell;
}




@end
