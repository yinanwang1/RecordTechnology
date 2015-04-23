//
//  NewFontDisplayViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/4/23.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "NewFontDisplayViewController.h"

@interface NewFontDisplayViewController ()

@property (weak, nonatomic) IBOutlet UILabel *showFontLabel;

@end

@implementation NewFontDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIFont *font = [UIFont fontWithName:@"GothamSSm-Black" size:20];
    
    
    self.showFontLabel.font = font;
    
    self.showFontLabel.text = @"What can I help you.";
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
