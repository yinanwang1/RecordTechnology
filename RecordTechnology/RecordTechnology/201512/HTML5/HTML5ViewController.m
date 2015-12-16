//
//  HTML5ViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/12/11.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "HTML5ViewController.h"

@interface HTML5ViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webview;


@end

@implementation HTML5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"Test1" ofType:@"js"];
    
    NSString *jsStr = [NSString stringWithContentsOfFile:pathStr encoding:NSUTF8StringEncoding error:nil];
    
    
    
    [self.webview loadHTMLString:jsStr baseURL:nil];
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
