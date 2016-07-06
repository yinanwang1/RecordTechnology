//
//  ModuleListModel.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/20.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "ModuleListModel.h"


@implementation ModuleListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSArray *)nameListArr
{
    _nameListArr = @[@"全部", @"纯图", @"功能页", @"带底文图", @"无底文图"];
    
    return _nameListArr;
}

- (NSArray *)collectionViewDataSource
{
    NSMutableArray *dataSource = [[NSMutableArray alloc] initWithCapacity:5];
    
    for (int i=0; i < NUMBER_PICTURES; i++)
    {
        NSString *imageNameStr = [NSString stringWithFormat:@"%d", (i + 1)];
        UIImage *image = [UIImage imageNamed:imageNameStr];
        
        [dataSource addObject:image];
    }
    
    return dataSource;
}


@end
