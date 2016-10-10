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

#define TAG_BASIC 1000

@interface MyTabBarView ()

@property (nonatomic, weak) UIButton *selectedBtn;

@property (nonatomic, strong) NSMutableArray *barItemMArr;
@property (nonatomic, strong) NSMutableArray *gifDataMArr;

@property (nonatomic, strong) FLAnimatedImageView *imageView;

@end

@implementation MyTabBarView

- (void)addButtonWithImage:(UIImage *)image selectdImage:(UIImage *)selectedImage gif:(NSData *)gifData
{
    // Gif
    [self.gifDataMArr addObject:gifData];
    
    
    // Buttons
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    
    [button addTarget:self
            action:@selector(onClickBtn:)
  forControlEvents:UIControlEventTouchUpInside];
    
    [self.barItemMArr addObject:button];
    
    [self addSubview:button];
    
    if (1 == [self.subviews count]) {
        [self onClickBtn:button];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = [self.barItemMArr count];
    for (int i = 0; i < count; i++) {
        UIButton *button = self.barItemMArr[i];
        
        button.tag = i + TAG_BASIC;
        
        CGFloat x = i * self.bounds.size.width / count;
        CGFloat y = 0;
        CGFloat width = self.bounds.size.width / count;
        CGFloat height = self.bounds.size.height;
        
        button.frame = CGRectMake(x, y, width, height);
    }
}


#pragma mark - Target Methods

- (void)onClickBtn:(UIButton *)btn
{
    if (self.imageView.isAnimating) {
        return;
    }
    
    BOOL differentBtn = self.selectedBtn.tag != btn.tag;
    
    self.selectedBtn.selected = NO;
    self.selectedBtn = btn;
    
    if (differentBtn) {
        [self showGifAtBtn:btn];
    } else {
        [self disappearGif];
    }
    
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self
                 selectedFrom:(self.selectedBtn.tag - TAG_BASIC)
                           to:(btn.tag - TAG_BASIC)];
    }
    
    
}

- (void)showGifAtBtn:(UIButton *)btn
{
    if (0.00 >= btn.center.x) {
        return;
    }
    
    NSData *data         = [self.gifDataMArr objectAtIndex:btn.tag - TAG_BASIC];
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
    
    if (nil == image) {
        return;
    }
    
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.animatedImage = image;
    imageView.frame = CGRectMake(0, 0, btn.imageView.image.size.width, btn.imageView.image.size.height);
    imageView.center = btn.center;
    imageView.userInteractionEnabled = NO;
    
    [self addSubview:imageView];
    
    imageView.animationRepeatCount = 1;
    [imageView startAnimating];
    
    self.imageView = imageView;
    
    CGFloat minDelayPerImage = 0.02;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(image.frameCount * minDelayPerImage * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self disappearGif];
    });
}

- (void)disappearGif
{
    [self.imageView stopAnimating];
    [self.imageView removeFromSuperview];
    
    [self.selectedBtn setSelected:YES];
}


#pragma mark - Getter Methods

- (NSMutableArray *)barItemMArr
{
    if (nil == _barItemMArr) {
        _barItemMArr = [[NSMutableArray alloc] initWithCapacity:5];
    }
    
    return _barItemMArr;
}

- (NSMutableArray *)gifDataMArr
{
    if (nil == _gifDataMArr) {
        _gifDataMArr = [[NSMutableArray alloc] initWithCapacity:5];
    }
    
    return _gifDataMArr;
}

@end
