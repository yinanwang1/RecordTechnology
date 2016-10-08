//
//  HXSTabBarItemView.h
//  RecordTechnology
//
//  Created by ArthurWang on 2016/10/8.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXSTabBarItemView : UIView

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (nonatomic, assign) BOOL selected;

@end
