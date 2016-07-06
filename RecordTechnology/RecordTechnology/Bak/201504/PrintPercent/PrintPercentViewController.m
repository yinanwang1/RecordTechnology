//
//  PrintPercentViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/4/21.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "PrintPercentViewController.h"

@interface PrintPercentViewController ()

@property (weak, nonatomic) IBOutlet UITextView *printPercentTextView;

@end

@implementation PrintPercentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *printPercentStr = [NSString stringWithFormat:@"%%"];
    
    NSLog(@"printPercentStr is %@.", printPercentStr);
    
    self.printPercentTextView.text = printPercentStr;
    
    
    
    
    
    
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
