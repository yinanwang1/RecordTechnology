//
//  YYTestViewController.h
//  RecordTechnology
//
//  Created by ArthurWang on 2017/9/25.
//  Copyright © 2017年 MonkeyKing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <YYKit/YYKit.h>

@protocol YYTestViewControllerDelegate;

@protocol YYTestViewControllerSubDelegate <YYTestViewControllerDelegate>

- (void)YYTestViewControllerSubDelegate:(NSString *)tst;

@end

@protocol YYTestViewControllerDelegate <NSObject>

- (void)YYTestViewController:(NSString *)test;

@end

@interface YYTestViewController : UIViewController

@end
