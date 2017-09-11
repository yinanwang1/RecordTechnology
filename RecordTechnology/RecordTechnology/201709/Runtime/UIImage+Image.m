//
//  UIImage+Image.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/9/1.
//  Copyright © 2017年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (void)load
{
    Method imageWithName = class_getClassMethod(self, @selector(imageWithName:));

    Method imageName = class_getClassMethod(self, @selector(imageNamed:));

    method_exchangeImplementations(imageWithName, imageName);
}

+ (instancetype)imageWithName:(NSString *)name
{
    UIImage *image = [self imageWithName:name];

    if (image == nil) {
        NSLog(@"加载空的图片");
    }

    return image;
}

@end
