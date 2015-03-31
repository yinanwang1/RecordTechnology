//
//  DrawLineView.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/31.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "DrawLineView.h"

@implementation DrawLineView


- (void)drawRect:(CGRect)rect {

//    CGContextRef contextRef = UIGraphicsGetCurrentContext();
//    
//    NSLog(@"[UIScreen mainScreen].scale is %f.", [UIScreen mainScreen].scale);
//    CGContextSetShouldAntialias(contextRef, NO);
//    
//    CGContextSetLineWidth(contextRef, 1/[UIScreen mainScreen].scale);
//    
//    CGContextSetRGBStrokeColor(contextRef, 0, 0, 0, 1.0);
//    CGContextMoveToPoint(contextRef, 50.3, 100.3);
//    CGContextAddLineToPoint(contextRef, 100.3, 300.3);
//    CGContextStrokePath(contextRef);
//    
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(50.3, 100.3)];
    [path addLineToPoint:CGPointMake(100.3, 300.3)];
    [path closePath];
    
    path.lineWidth = 1/[UIScreen mainScreen].scale;
    [[UIColor redColor] setStroke];
    
    [path stroke];
    
    
}


@end
