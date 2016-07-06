//
//  CIFilterViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/10/17.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "CIFilterViewController.h"

#import "HXSQRCodes.h"

@interface CIFilterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *filterTextField;
@property (weak, nonatomic) IBOutlet UIButton *filterButton;
@property (weak, nonatomic) IBOutlet UIImageView *filterImageView;


@end

@implementation CIFilterViewController

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

- (IBAction)onClickFliterBtn:(id)sender
{
    [self.filterTextField resignFirstResponder];
    
    if (nil == self.filterTextField.text
        || (0 >= [self.filterTextField.text length])) {
        return;
    }
    
    self.filterImageView.image = [HXSQRCodes createImageWithQRString:self.filterTextField.text
                                                                size:self.filterImageView.frame.size.width
                                                               color:nil
                                                                icon:[UIImage imageNamed:@"filterIcon"]];
    
}



























@end
