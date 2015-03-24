//
//  ModuleListViewController.h
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/20.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModuleListViewControllerDelegate <NSObject>

@optional
- (void)hasSelectedStyle:(NSString *)styleNameStr;

@end

@interface ModuleListViewController : UIViewController

@property (nonatomic, assign) id<ModuleListViewControllerDelegate> moduleListDelegate;


@end
