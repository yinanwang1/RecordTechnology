//
//  BlockToSelectorViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/30.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "BlockToSelectorViewController.h"

typedef NSString *(^BlockToSelector)(NSString *name);

@interface BlockToSelectorViewController ()

@property (nonatomic, strong) BlockToSelector blockTest;

@end

@implementation BlockToSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.blockTest = ^(NSString *name){
        
        NSString *string = [NSString stringWithFormat:@"Block test %@", name];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"hello"
                                                        message:string
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        
        
        [alert show];
        
        NSLog(@"sele.blocktest is %@", name);
        
        return string;
    };
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}
- (IBAction)clickShowBtn:(id)sender {
    
//    [self performSelector:@selector(showHello)
//               withObject:nil
//               afterDelay:1.0];
    
    NSLog(@"blocktest is %@.", _blockTest);
    [self performSelector:@selector(blockTest)
               withObject:@"hello"
               afterDelay:1];
    
    
    
}

- (void)testBlock:(NSString *)name
{
    NSLog(@"_blockTest is %@", _blockTest(name));

}

- (void)showHello
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"hello"
                                                    message:@"Block test"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    
    
    [alert show];
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
