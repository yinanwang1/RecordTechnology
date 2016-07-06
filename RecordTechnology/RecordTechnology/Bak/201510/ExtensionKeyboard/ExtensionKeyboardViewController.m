//
//  ExtensionKeyboardViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/10/30.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "ExtensionKeyboardViewController.h"

@interface ExtensionKeyboardViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

@implementation ExtensionKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


- (IBAction)onClickDoneBtn:(id)sender
{
    [self.textField resignFirstResponder];
}


@end
