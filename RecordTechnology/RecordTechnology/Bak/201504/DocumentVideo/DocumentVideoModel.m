//
//  DocumentVideoModel.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/4/4.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "DocumentVideoModel.h"

@implementation DocumentVideoModel


- (NSArray *)dataSource
{
    if ( nil == _dataSource )
    {
        NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"DocumentVideo" ofType:@"plist"];
        
        NSLog(@"pathStr is %@.", pathStr);
        
        NSArray *dataSource = [NSArray arrayWithContentsOfFile:pathStr];
        
        _dataSource = [dataSource copy];
        
    }
    
    return _dataSource;
}



@end
