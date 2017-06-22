//
//  HXQIndicatorProgressView.m
//  qiji
//
//  Created by ArthurWang on 2016/12/21.
//  Copyright © 2016年 huanxiao. All rights reserved.
//

#import "HXQIndicatorProgressView.h"

@implementation HXQIndicatorProgressView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4.0f;
}


#pragma mark - Public Methods

+ (instancetype)indicatorProgressView
{
    HXQIndicatorProgressView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HXQIndicatorProgressView class]) owner:self options:nil].firstObject;
    
    return view;
}

@end
