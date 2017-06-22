//
//  MBProgressHUD+HXS.h
//  59dorm
//
//  Created by ArthurWang on 15/9/7.
//  Copyright (c) 2015年 Huanxiao. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (HXS)

/*
 * 仅仅显示text，并在delay秒后关闭
 */
+ (instancetype)showInViewWithoutIndicator:(UIView *)view
                                    status:(NSString *)text
                                afterDelay:(NSTimeInterval)delay;

/*
 * 仅仅显示text和顶部image，并在delay秒后关闭
 */
+ (instancetype)showInViewWithoutIndicator:(UIView *)view
                                    status:(NSString *)text
                                     image:(UIImage *)image
                                afterDelay:(NSTimeInterval)delay;

/*
 * 仅仅显示一个转圈
 */
+ (instancetype)showInView:(UIView *)view;

/*
 * 左边显示一个转圈，右边显示text
 */
+ (instancetype)showInView:(UIView *)view status:(NSString *)text;

/*
 * 顶部显示单车的动画，下边显示text
 */
+ (instancetype)showLoading:(UIView *)view
                     status:(NSString *)text;

@end
