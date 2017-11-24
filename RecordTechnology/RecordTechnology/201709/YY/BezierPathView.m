//
//  BezierPathView.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/11/9.
//  Copyright © 2017年 Monkey King. All rights reserved.
//

#import "BezierPathView.h"

#import <YYKit/YYKit.h>

@implementation BezierPathView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    UIBezierPath *bezier = [UIBezierPath bezierPathWithText:@"这个是怎么使用的啊" font:[UIFont systemFontOfSize:30.0f]];


    [bezier setLineWidth:2.0f];
    [[UIColor cyanColor] setStroke];
    [bezier stroke];
}

@end
