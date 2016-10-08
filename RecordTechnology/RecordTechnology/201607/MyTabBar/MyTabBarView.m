//
//  MyTabBarView.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/7/12.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "MyTabBarView.h"

#import "HomeViewController.h"
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"
#import "HXSTabBarItemView.h"

#define TAG_BASIC 1000

@interface MyTabBarView ()

@property (nonatomic, weak) HXSTabBarItemView *selectedItemView;

@property (nonatomic, strong) NSMutableArray *barItemMArr;
@property (nonatomic, strong) FLAnimatedImageView *imageView;

@end

@implementation MyTabBarView

- (void)addButtonWithImage:(UIImage *)image selectdImage:(UIImage *)selectedImage
{
    HXSTabBarItemView *itemView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HXSTabBarItemView class]) owner:nil options:nil].firstObject;
    
    [itemView.button setImage:image forState:UIControlStateNormal];
    [itemView.button setImage:selectedImage forState:UIControlStateSelected];
    
    [itemView.button addTarget:self
            action:@selector(onClickBtn:)
  forControlEvents:UIControlEventTouchUpInside];
    
    [self.barItemMArr addObject:itemView];
    
    [self addSubview:itemView];
    
    if (1 == [self.subviews count]) {
        [self onClickBtn:itemView.button];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = [self.barItemMArr count];
    for (int i = 0; i < count; i++) {
        HXSTabBarItemView *view = self.barItemMArr[i];
        
        view.button.tag = i + TAG_BASIC;
        
        CGFloat x = i * self.bounds.size.width / count;
        CGFloat y = 0;
        CGFloat width = self.bounds.size.width / count;
        CGFloat height = self.bounds.size.height;
        
        view.frame = CGRectMake(x, y, width, height);
    }
}


#pragma mark - Target Methods

- (void)onClickBtn:(UIButton *)btn
{
    if (self.selectedItemView.button.tag != btn.tag) {
        [self showGifAtBtn:btn];
    }
    
    self.selectedItemView.selected = NO;
    
    HXSTabBarItemView *itemView = (HXSTabBarItemView *)btn.superview;
    itemView.selected = YES;
    
    self.selectedItemView = itemView;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self
                 selectedFrom:(self.selectedItemView.button.tag - TAG_BASIC)
                           to:(btn.tag - TAG_BASIC)];
    }
    
    
}

- (void)showGifAtBtn:(UIButton *)btn
{
    if (self.imageView.isAnimating) {
        return;
    }
    
    if (0.00 >= btn.center.x) {
        return;
    }
    
    NSString* gifPath    = [[NSBundle mainBundle] pathForResource:@"order"
                                                           ofType:@"gif"];
    
    NSData *data         = [NSData dataWithContentsOfFile:gifPath];
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
    
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.animatedImage = image;
    imageView.frame = CGRectMake(0, 0, btn.imageView.image.size.width, btn.imageView.image.size.height);
    imageView.center = btn.center;
    imageView.userInteractionEnabled = NO;
    
    [self addSubview:imageView];
    
    imageView.animationRepeatCount = 1;
    [imageView startAnimating];
    
    self.imageView = imageView;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((image.frameCount / 30) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self disappearGif];
    });
}

- (void)disappearGif
{
    [self.imageView stopAnimating];
    [self.imageView removeFromSuperview];
}


#pragma mark - Getter Methods

- (NSMutableArray *)barItemMArr
{
    if (nil == _barItemMArr) {
        _barItemMArr = [[NSMutableArray alloc] initWithCapacity:5];
    }
    
    return _barItemMArr;
}

@end
