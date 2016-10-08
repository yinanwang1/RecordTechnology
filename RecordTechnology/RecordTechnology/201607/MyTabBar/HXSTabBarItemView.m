//
//  HXSTabBarItemView.m
//  RecordTechnology
//
//  Created by ArthurWang on 2016/10/8.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "HXSTabBarItemView.h"

@implementation HXSTabBarItemView

@synthesize selected = _selected;

- (BOOL)selected
{
    return _selected;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    [self.button setSelected:selected];
}

@end
