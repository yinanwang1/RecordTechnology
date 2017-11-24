//
//  UIView+Utilities.m
//  store
//
//  Created by hudezhi on 15/11/5.
//  Copyright © 2015年 Arthur Wang All rights reserved.
//

#import "UIView+Utilities.h"

#import "HXMacrosUtils.h"

@implementation UIView (Utilities)

- (void)shake
{
    CGPoint center = self.center;
    
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    shakeAnimation.duration = 0.1;
    shakeAnimation.repeatCount = 2;
    shakeAnimation.autoreverses = YES;
    shakeAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(center.x - 5, center.y)];
    shakeAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(center.x + 5, center.y)];
    
    [self.layer removeAnimationForKey:@"shakePosition"];
    [self.layer addAnimation:shakeAnimation forKey:@"shakePosition"];
}

+ (void)printView:(UIView*)view prefix: (NSString*)prefix
{
    DLog(@"%@ : %@", prefix, [view class]);
    for(UIView* sub in view.subviews) {
        [UIView printView:sub prefix:[NSString stringWithFormat:@"    %@", prefix]];
    }
}

+ (instancetype)viewFromNib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
}

+ (instancetype)viewFromNibWithModuleName:(NSString *)moduleNameStr
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *bundlePath = [bundle pathForResource:moduleNameStr ofType:@"bundle"];
    if (bundlePath) {
        bundle = [NSBundle bundleWithPath:bundlePath];
    }
    
    return [bundle loadNibNamed:NSStringFromClass([self class])
                          owner:self
                        options:nil].lastObject;
}

@end
