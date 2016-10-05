//
//  PageControlViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2016/9/24.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "PageControlViewController.h"

#import "CustomPageControl.h"

@interface PageControlViewController ()

@property (weak, nonatomic) IBOutlet CustomPageControl *customPageControl;

@end

@implementation PageControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.customPageControl.numberOfPages = 2;
    self.customPageControl.currentPage = 1;
    self.customPageControl.thumbImage = [UIImage imageNamed:@"ic_jifenshangcheng_normal"];
    self.customPageControl.selectedThumbImage = [UIImage imageNamed:@"ic_lingshihe_normal"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
