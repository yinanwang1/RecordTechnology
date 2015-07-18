//
//  ShowKeyboardViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/7/18.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "ShowKeyboardViewController.h"

@interface ShowKeyboardViewController () <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, assign) BOOL hasHiddenKeyboard;


@end

@implementation ShowKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 50, 40)];
    [button setTitle:@"Back" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(onClickBack:)
     forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    self.navigationItem.leftBarButtonItem = leftButton;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showKeyboard:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dismissKeybaord:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)showKeyboard:(id)notification
{
    self.hasHiddenKeyboard = NO;
}

- (void)dismissKeybaord:(id)notification
{
    self.hasHiddenKeyboard = YES;
}

- (void)onClickBack:(UIButton *)button
{
    
    [self.view endEditing:YES];
    
    while ( !self.hasHiddenKeyboard )
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                    message:@"Will Dismiss."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    
    [alert show];
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(nonnull UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
