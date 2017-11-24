//
//  UINavigationBar+AlphaTransition.h
//  store
//
//  Created by hudezhi on 15/11/18.
//  Copyright © 2015年 Arthur Wang All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UINavigationBar (AlphaTransition)

- (void)at_setBackgroundColor:(UIColor *)backgroundColor;

- (void)at_setElementsAlpha:(CGFloat)alpha;

- (void)at_resetBackgroundColor:(UIColor *)backgroundColor translucent:(BOOL)translucent;

- (void)at_setTitleAlpha:(CGFloat)alpha;

@end
