//
//  CustomPageControl.h
//  RecordTechnology
//
//  Created by ArthurWang on 2016/9/24.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPageControl : UIControl

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, assign) BOOL hidesForSinglePage;

@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, strong) UIImage *selectedThumbImage;

@end
