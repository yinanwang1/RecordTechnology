//
//  DefineTabBar.h
//  RecordTechnology
//
//  Created by ArthurWang on 15/12/31.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DefineTabBar;

@protocol DefineBarDelegate <NSObject>

- (void)tabBar:(DefineTabBar *)tabBar selectedForm:(NSInteger)from to:(NSInteger)to;

@end

@interface DefineTabBar : UIView

@property (nonatomic, assign) id<DefineBarDelegate> tabBarDelegate;

- (void)addButtonWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;

@end
