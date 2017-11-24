//
//  HXImageUtil.h
//  store
//
//  Created by Arthur Wang on 14-10-14.
//  Copyright (c) 2014年 Arthur Wang All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HXImageUtil : NSObject

+ (UIImage*)scaleImage:(UIImage *)srcImg toSize:(CGSize)targetSize;

+ (UIImage *)scaleImage:(UIImage *)srcImg toMaxPixels:(float)maxLength;

@end
