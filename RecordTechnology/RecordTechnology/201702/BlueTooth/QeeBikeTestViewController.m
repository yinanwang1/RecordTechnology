//
//  QeeBikeTestViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/6/17.
//  Copyright © 2017年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "QeeBikeTestViewController.h"

#import "HXQBleManager.h"


@interface QeeBikeTestViewController () <HXQBleManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *bikeNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property (weak, nonatomic) IBOutlet UITextField *typeTextField;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (weak, nonatomic) IBOutlet UITextView *requestTextView;

@property (weak, nonatomic) IBOutlet UITextView *responseTextView;

@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@end

@implementation QeeBikeTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [HXQBleManager sharedManager];
    
    UIButton *clear = [UIButton buttonWithType:UIButtonTypeCustom];
    [clear setFrame:CGRectMake(0, 0, 44, 44)];
    [clear setTitle:@"清空" forState:UIControlStateNormal];
    [clear addTarget:self action:@selector(clearAll) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clear];
    
}

- (void)clearAll
{
    [[HXQBleManager sharedManager] close];
    
    self.bikeNoTextField.text = nil;
    self.keyTextField.text = nil;
    self.typeTextField.text = nil;
    self.contentTextField.text = nil;
    self.requestTextView.text = nil;
    self.responseTextView.text = nil;
    
    [self.sendBtn setTitle:@"连接" forState:UIControlStateNormal];
}

- (void)responseWithType:(BleResponseType)type content:(NSString *)content
{
    DLog(@"wyn responseWithType type is %zd content is %@", type, content);
    
    NSString *response  = [NSString stringWithFormat:@"应答数据 type is %zd content is %@.", type, content];
    
    self.responseTextView.text = [NSString stringWithFormat:@"%@\n%@", self.responseTextView.text, response];
}

- (void)connectSuccess:(BOOL)success
{
    if (success) {
        [self.sendBtn setTitle:@"已连接" forState:UIControlStateNormal];
    } else {
        [self.sendBtn setTitle:@"连接失败" forState:UIControlStateNormal];
        
        [self connect:nil];
    }
}

- (void)writeLog:(NSString *)log
{
    self.requestTextView.text = [NSString stringWithFormat:@"%@\n%@", self.requestTextView.text, log];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)connect:(id)sender
{
    [self.view endEditing:YES];
    
    if (0 >= self.bikeNoTextField.text) {
        self.requestTextView.text = [NSString stringWithFormat:@"%@\n%@", self.requestTextView.text, @"请输入单车编号"];
        
        return;
    }
    
    [[HXQBleManager sharedManager] connectBleWithBikeNo:self.bikeNoTextField.text delegate:self];
}

- (IBAction)send:(id)sender
{
    [self.view endEditing:YES];
    
    if (0 >= self.keyTextField.text) {
        self.requestTextView.text = [NSString stringWithFormat:@"%@\n%@", self.requestTextView.text, @"请输入key"];
        return;
    }
    
    if (0 >= self.typeTextField.text) {
        self.requestTextView.text = [NSString stringWithFormat:@"%@\n%@", self.requestTextView.text, @"请输入type"];
        return;
    }
    
    if (0 >= self.contentTextField.text) {
        self.requestTextView.text = [NSString stringWithFormat:@"%@\n%@", self.requestTextView.text, @"请输入content"];
        return;
    }
    
    [[HXQBleManager sharedManager] operationBleWithKey:self.keyTextField.text
                                                type:[self.typeTextField.text integerValue]
                                               content:self.contentTextField.text];
    
    NSString *request = [NSString stringWithFormat:@"key: %@, type: %@, content: %@", self.keyTextField.text, self.typeTextField.text, self.contentTextField.text];
    self.requestTextView.text = [NSString stringWithFormat:@"%@\n%@", self.requestTextView.text, request];
    
}



@end
