//
//  CameronDefinedViewController.h
//  RecordTechnology
//
//  Created by ArthurWang on 16/1/29.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CameraDefinedViewControllerDelegate <NSObject>

@required
- (void)didSelectTakePictureBtn;
- (void)didSelectCancelBtn;

@end

@interface CameraDefinedViewController : UIViewController

@property (nonatomic, assign) id<CameraDefinedViewControllerDelegate> delegate;

@end
