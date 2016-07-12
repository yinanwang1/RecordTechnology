//
//  MyTabBarView.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/7/12.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "MyTabBarView.h"


@interface MyTabBarView ()

@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation MyTabBarView

- (void)addButtonWithImage:(UIImage *)image selectdImage:(UIImage *)selectedImage
{
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    
    [self addSubview:btn];
    
    [btn addTarget:self
            action:@selector(onClickBtn:)
  forControlEvents:UIControlEventTouchUpInside];
    
    if (1 == [self.subviews count]) {
        [self onClickBtn:btn];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = [self.subviews count];
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        
        btn.tag = i;
        
        CGFloat x = i * self.bounds.size.width / count;
        CGFloat y = 0;
        CGFloat width = self.bounds.size.width / count;
        CGFloat height = self.bounds.size.height;
        
        btn.frame = CGRectMake(x, y, width, height);
    }
}


#pragma mark - Target Methods

- (void)onClickBtn:(UIButton *)btn
{
    self.selectedBtn.selected = NO;
    
    btn.selected = YES;
    
    self.selectedBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self
                 selectedFrom:self.selectedBtn.tag
                           to:btn.tag];
    }
}

@end
