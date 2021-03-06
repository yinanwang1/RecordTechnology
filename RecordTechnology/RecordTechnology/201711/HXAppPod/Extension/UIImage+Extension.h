//
//  UIImage+Extension.h
//  store
//
//  Created by hudezhi on 15/7/25.
//  Copyright (c) 2015年 Arthur Wang All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Extension)

+ (UIImage*) imageFromColor:(UIColor *)color;
+ (UIImage*) imageFromLayer:(CALayer*) layer;
- (NSString *)convertImageToString;
- (UIImage *)imageByScalingToMaxSize;
/**
 *  图片剪切成圆角图片
 *
 *  @return 圆角图片
 */
- (UIImage *)convertToCornerImage;

// 生成原角图片
+ (UIImage *)createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius;

/**
 *将图片缩放到指定的CGSize大小
 * UIImage image 原始的图片
 * CGSize size 要缩放到的大小
 */
- (UIImage*)scaleToSize:(CGSize)size;

@end
