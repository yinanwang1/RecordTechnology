//
//  DateViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/6/1.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "DateViewController.h"

#import "ConvertDateAndStringEachOther.h"

@interface DateViewController ()

@end

@implementation DateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDate *date = [ConvertDateAndStringEachOther dateFromString:@"2014-10-12T20:22:12Z"
                                                    formatString:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    
    NSLog(@"Date is %@.", date);
    
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
