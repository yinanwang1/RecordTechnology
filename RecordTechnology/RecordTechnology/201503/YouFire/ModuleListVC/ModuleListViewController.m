//
//  ModuleListViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/20.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "ModuleListViewController.h"

#import "ModuleListModel.h"
#import "FunctionCollectionViewCell.h"


NSString * const collectionViewCell = @"FunctionCollectionViewCell";
NSString * const editingVCIdentifier = @"showEditingView";

@interface ModuleListViewController () <UICollectionViewDelegate,
                                        UICollectionViewDataSource,
                                        UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIScrollView *nameListScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *functionItemCollectionView;

@property (nonatomic, strong) ModuleListModel *moduleListModel;


@end

@implementation ModuleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDataSource];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self initTitlesOfScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark -- Init Data source

- (void)initDataSource
{
    if ( nil == _moduleListModel )
    {
        _moduleListModel = [[ModuleListModel alloc] init];
    }
    
    // collection view
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewLayout.minimumInteritemSpacing = 20;
    collectionViewLayout.minimumLineSpacing = 20;
    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.functionItemCollectionView.collectionViewLayout = collectionViewLayout;
    self.functionItemCollectionView.delegate = self;
    self.functionItemCollectionView.dataSource = self;
    
    [self.functionItemCollectionView registerNib:[UINib nibWithNibName:collectionViewCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:collectionViewCell];
}

#pragma mark -- Init status Views

- (void)initTitlesOfScrollView
{
    CGFloat height = self.nameListScrollView.frame.size.height;
    CGFloat weight = 100.0f;
    
    for ( int i=0; i < [self.moduleListModel.nameListArr count]; i++ )
    {
        NSString *title = [self.moduleListModel.nameListArr objectAtIndex:i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor whiteColor]];
        if ( 0 == i )
        {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        else
        {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        [button setTitle:title forState:UIControlStateNormal];
        [button setFrame:CGRectMake(weight * i, 0, weight, height)];
        [button addTarget:self
                   action:@selector(displayFuctions:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [self.nameListScrollView addSubview:button];
    }
    
    self.nameListScrollView.contentSize = CGSizeMake(weight * [self.moduleListModel.nameListArr count], height);
}

- (void)displayFuctions:(id)sender
{
    for ( UIView *view in [self.nameListScrollView subviews] )
    {
        if ( [view isKindOfClass:[UIButton class]] )
        {
            UIButton *button = (UIButton *)view;
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    
    UIButton *button = (UIButton *)sender;
    
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    
}


#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return NUMBER_PICTURES;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FunctionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCell forIndexPath:indexPath];
    
    cell.functionImageView.image = [self.moduleListModel.collectionViewDataSource objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:editingVCIdentifier sender:indexPath];
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 126);
}


@end
