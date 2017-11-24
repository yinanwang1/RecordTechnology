//
//  HXSLocationSearchBar.m
//  store
//
//  Created by Arthur Wang on 15/2/3.
//  Copyright (c) 2015年 Arthur Wang All rights reserved.
//

#import "HXSLocationSearchBar.h"

#import "UIView+Extension.h"

@implementation HXSLocationSearchBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIButton *cancelBtn = (UIButton*)[self subviewOfClassType:[UIButton class] searchRecursively:YES];
    if (cancelBtn) {
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消 " forState:UIControlStateNormal];
    }
}

@end
