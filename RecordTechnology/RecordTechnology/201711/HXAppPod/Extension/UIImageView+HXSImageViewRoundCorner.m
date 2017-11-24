//
//  UIImageView+HXSImageViewRoundCorner.m
//  store
//
//  Created by J006 on 16/4/27.
//  Copyright © 2016年 Arthur Wang All rights reserved.
//

#import "UIImageView+HXSImageViewRoundCorner.h"

@implementation UIImageView (HXSImageViewRoundCorner)

- (void)cornerRadiusForImageViewWithImage:(UIImage *)image
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [[UIBezierPath bezierPathWithRoundedRect:self.bounds
                                cornerRadius:self.frame.size.width/2] addClip];
    [image drawInRect:self.bounds];
    
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
}

@end
