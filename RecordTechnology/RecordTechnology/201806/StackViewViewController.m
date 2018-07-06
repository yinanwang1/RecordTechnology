//
//  StackViewViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2018/7/3.
//  Copyright © 2018年 Monkey King. All rights reserved.
//

#import "StackViewViewController.h"

@interface StackViewViewController ()

@property (weak, nonatomic) IBOutlet UIStackView *myStackView;

@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UILabel *label4;




@end

@implementation StackViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickDeleteBtn:(id)sender
{
    NSLog(@"self.label1.superview is %@.", self.label1.superview);
    NSLog(@"self.label1 is %@", NSStringFromCGRect(self.label1.frame));
    
    [self.myStackView removeArrangedSubview:self.label1];

//    [self.label1 removeFromSuperview];

    NSLog(@"self.label1.superview is %@.", self.label1.superview);
    NSLog(@"self.label1 is %@", NSStringFromCGRect(self.label1.frame));
}

- (IBAction)onClickAddBtn:(id)sender
{
//    [self.view addSubview:self.label1];

    [self.myStackView addArrangedSubview:self.label1];


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
