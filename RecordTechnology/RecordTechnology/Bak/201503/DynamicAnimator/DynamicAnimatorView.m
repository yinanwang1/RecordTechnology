//
//  DynamicAnimatorView.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/26.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "DynamicAnimatorView.h"

@interface DynamicAnimatorView ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat from;
@property (nonatomic, assign) CGFloat to;
@property (nonatomic, assign) BOOL animating;

@end

@implementation DynamicAnimatorView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)startAnimationFrom:(CGFloat)from to:(CGFloat)to
{
    self.from = from;
    self.to = to;
    self.animating = YES;
    
    if ( nil == self.displayLink )
    {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
}


- (void)completeAnimation
{
    self.animating = NO;
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)tick:(CADisplayLink *)displayLink
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CALayer *layer = self.layer.presentationLayer;
    CGFloat progress = 1;
    if ( !self.animating )
    {
        progress = 1;
    }
    else
    {
        progress = 1 - (layer.position.y - self.to) / (self.from - self.to);
    }
    
    CGFloat height = CGRectGetHeight(rect);
    CGFloat deltaHeight = height / 2 * (0.5 - fabs(progress - 0.5));
//    NSLog(@"deltaHeight is %f.", deltaHeight);
    
    CGPoint topLeft = CGPointMake(0, deltaHeight);
    CGPoint topRight = CGPointMake(CGRectGetWidth(rect), deltaHeight);
    CGPoint bottomLeft = CGPointMake(0, height);
    CGPoint bottomRight = CGPointMake(CGRectGetWidth(rect), height);
    
    NSLog(@"topLeft is %@. topRight is %@, bottomLeft is %@, bottomRight is %@.", NSStringFromCGPoint(topLeft), NSStringFromCGPoint(topRight), NSStringFromCGPoint(bottomLeft), NSStringFromCGPoint(bottomRight));
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [[UIColor redColor] setFill];
    [path moveToPoint:topLeft];
    [path addQuadCurveToPoint:topRight controlPoint:CGPointMake(CGRectGetMidX(rect), 0)];
    [path addLineToPoint:bottomRight];
    [path addQuadCurveToPoint:bottomLeft controlPoint:CGPointMake(CGRectGetMidX(rect), height - deltaHeight)];
    [path closePath];
    [path fill];
}






@end
