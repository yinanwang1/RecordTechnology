//
//  MyTabBarView.h
//  RecordTechnology
//
//  Created by ArthurWang on 16/7/12.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyTabBarView;

@protocol MyTabBarViewDelegate <NSObject>

- (void)tabBar:(MyTabBarView *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface MyTabBarView : UIView

@property (nonatomic, weak) id<MyTabBarViewDelegate> delegate;

- (void)addButtonWithImage:(UIImage *)image selectdImage:(UIImage *)selectedImage gif:(NSData *)gifData;

@end
