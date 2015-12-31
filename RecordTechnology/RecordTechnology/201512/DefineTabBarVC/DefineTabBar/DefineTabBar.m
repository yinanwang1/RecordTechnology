//
//  DefineTabBar.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/12/31.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "DefineTabBar.h"

@interface DefineTabBar ()

@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation DefineTabBar

- (id)init
{
    if (self == [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}


#pragma mark - Public Methods

- (void)addButtonWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    
    [self addSubview:btn];
    
    
    [btn addTarget:self
            action:@selector(onClickBtn:)
  forControlEvents:UIControlEventTouchUpInside];
    
    if (1 == [self.subviews count]) {
        [self onClickBtn:btn];
    }
}


#pragma mark - Override Methods

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = [self.subviews count];
    for (int i = 0; i < count; i++) {
        UIButton *btn = [self.subviews objectAtIndex:i];
        btn.tag = i;
        
        CGFloat x = i * self.bounds.size.width / count;
        CGFloat y = 0;
        CGFloat width = self.bounds.size.width / count;
        CGFloat height = self.bounds.size.height;
        btn.frame = CGRectMake(x, y, width, height);
        
        if (2 == i) {
            btn.frame = CGRectMake(x, y - 10, width, height + 10);
        }
    }
}


#pragma mark - Target Methods

- (void)onClickBtn:(UIButton *)button
{
    self.selectedBtn.selected = NO;
    
    button.selected = YES;
    
    if ([self.tabBarDelegate respondsToSelector:@selector(tabBar:selectedForm:to:)]) {
        [self.tabBarDelegate tabBar:self selectedForm:self.selectedBtn.tag to:button.tag];
    }
    
    self.selectedBtn = button;
}

@end
