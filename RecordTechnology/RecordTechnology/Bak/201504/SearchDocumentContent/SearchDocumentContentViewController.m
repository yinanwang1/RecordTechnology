//
//  SearchDocumentContentViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/4/7.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "SearchDocumentContentViewController.h"

@interface SearchDocumentContentViewController ()

@end

@implementation SearchDocumentContentViewController

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
- (IBAction)searchDocumentContent:(id)sender
{
    NSString *searchContextStr = @"iphone";
    
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"UIView" ofType:@"docx"];
    NSData *data = [NSData dataWithContentsOfFile:pathStr];
    
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"string is %@.", string);
    
    
    
    
    NSLog(@"data is %@.", data);
    
    
}




@end
