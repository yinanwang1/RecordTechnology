//
//  LuaViewViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/8/17.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "LuaViewViewController.h"

#import "LView.h"

@interface LuaViewViewController ()

@property (nonatomic, strong) LView *lv;

@end

@implementation LuaViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect lvRect = self.view.bounds;
    lvRect.origin = CGPointZero;
    
    
    self.lv = [[LView alloc] initWithFrame:lvRect];
    self.lv.viewController = self;
    
    [self.view addSubview:self.lv];
    
    [self.lv runFile:@"HelloWorld.lua"];
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
