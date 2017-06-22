//
//  MBProgressHUD+HXS.m
//  59dorm
//
//  Created by ArthurWang on 15/9/7.
//  Copyright (c) 2015年 Huanxiao. All rights reserved.
//

#import "MBProgressHUD+HXS.h"

#import "HXQIndicatorProgressView.h"

@interface LoadingBackgroundView : UIView

@end

@implementation LoadingBackgroundView

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(60, 60);
}

@end

@implementation MBProgressHUD (HXS)

+ (instancetype)showInViewWithoutIndicator:(UIView *)view status:(NSString *)text afterDelay:(NSTimeInterval)delay
{
    if (nil == view) {
        return nil;
    }
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.color = [UIColor colorWithARGBHex:0xB2000000];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    [hud setMode:MBProgressHUDModeText];
    hud.detailsLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    hud.detailsLabel.text = text;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:delay];
    

    return hud;
}

+ (instancetype)showInViewWithoutIndicator:(UIView *)view
                                    status:(NSString *)text
                                     image:(UIImage *)image
                                afterDelay:(NSTimeInterval)delay
{
    if (nil == view) {
        return nil;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.color = [UIColor colorWithARGBHex:0xB2000000];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    UIImage *temimage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    hud.customView = [[UIImageView alloc] initWithImage:temimage];
    hud.label.font = [UIFont systemFontOfSize:15];
    hud.label.text = text;
    hud.label.textColor = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:delay];
    
    return hud;
}

+ (instancetype)showInView:(UIView *)view
{
    if (nil == view) {
        return nil;
    }
    
    return [MBProgressHUD showInView:view status:@""];
}

+ (instancetype)showInView:(UIView *)view status:(NSString *)text
{
    if (nil == view) {
        return nil;
    }
    
    HXQIndicatorProgressView *progressView = [HXQIndicatorProgressView indicatorProgressView];
    progressView.textLabel.text = text;
    
    [progressView layoutIfNeeded];
    
    // create HUD
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = progressView;
    hud.margin     = 0.0f;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
    hud.backgroundView.color = [UIColor clearColor];
    
    return hud;
}


@end

