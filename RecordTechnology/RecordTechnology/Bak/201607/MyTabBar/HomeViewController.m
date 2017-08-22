//
//  TestViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/7/15.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
{
    NSString *nameStr;
}

@property (nonatomic, strong) NSString *testStr;

- (NSString *)nameStr;

- (void)setNameStr:(NSString *)newValue;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (NSString *)nameStr {
    return nameStr;
}

- (void)setNameStr:(NSString *)newValue {
    nameStr = newValue;
}





@end
