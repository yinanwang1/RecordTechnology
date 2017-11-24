//
//  UIImageView+HXSImageViewRoundCorner.h
//  store
//
//  Created by J006 on 16/4/27.
//  Copyright © 2016年 Arthur Wang All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (HXSImageViewRoundCorner)

/**
 *  指定的要变成圆形的图片
 *
 *  @param image
 */
- (void)cornerRadiusForImageViewWithImage:(UIImage *)image;

@end
