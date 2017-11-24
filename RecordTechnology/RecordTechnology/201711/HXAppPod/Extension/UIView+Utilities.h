//
//  UIView+Utilities.h
//  store
//
//  Created by hudezhi on 15/11/5.
//  Copyright © 2015年 Arthur Wang All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utilities)

- (void)shake;

+ (void)printView:(UIView*)view prefix: (NSString*)prefix;

+ (instancetype)viewFromNib;

+ (instancetype)viewFromNibWithModuleName:(NSString *)moduleNameStr;

@end
