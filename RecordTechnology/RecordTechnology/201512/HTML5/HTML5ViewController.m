//
//  HTML5ViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/12/11.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "HTML5ViewController.h"

@interface HTML5ViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webview;


@end

@implementation HTML5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"Test8" ofType:@"js"];
    
    NSString *jsStr = [NSString stringWithContentsOfFile:pathStr encoding:NSUTF8StringEncoding error:nil];
    
    
    
    [self.webview loadHTMLString:jsStr baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"smart" ofType:@"jpg"];
    
    NSString *jsString = [NSString stringWithFormat:@"setImagePath('file://%@')", pathStr];
    
    [webView stringByEvaluatingJavaScriptFromString:jsString];
}



@end
