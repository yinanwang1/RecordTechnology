//
//  FansViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/6/17.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "FansViewController.h"

@interface FansViewController ()

@end

@implementation FansViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if ( nil != self )
//    {
//        
//    }
//    
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismiss)];
    
    
    
    [self.view addGestureRecognizer:tap];
    
    
    UIColor *white = RGBA(255, 255, 255, 0.5);
    
    [self.view setBackgroundColor:white];

    
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 
                             }];
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
