//
//  AllEffectInstance.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/24.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "AllEffectInstance.h"

#import "Style1ViewController.h"
#import "Style2ViewController.h"

@interface AllEffectInstance ()

@property (nonatomic, strong) Style1ViewController *style1VC;
@property (nonatomic, strong) Style2ViewController *style2VC;

@end


@implementation AllEffectInstance

#pragma mark -- Lifestyle methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    
}


#pragma mark -- Public methods

- (UIView *)createEffectVCInstanceWithName:(NSString *)nameStr
{
    UIView *view = nil;
    
    if ( [nameStr isEqualToString:@"1"] )
    {
        _style1VC = [[Style1ViewController alloc] initWithNibName:@"Style1ViewController" bundle:[NSBundle mainBundle]];
        
        view = _style1VC.view;
    }
    else
    {
        _style2VC = [[Style2ViewController alloc] initWithNibName:@"Style2ViewController" bundle:[NSBundle mainBundle]];
        
        view = _style2VC.view;
    }
    
    return view;
}

@end
