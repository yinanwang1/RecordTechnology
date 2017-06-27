//
//  QeeBikeTestViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/6/17.
//  Copyright © 2017年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "QeeBikeTestViewController.h"

#import "HXQBleManager.h"
#import "AESCipher.h"

typedef NS_ENUM(NSInteger, BleCellFuction){
    kBleCellFuctionUnlock = 0,
    kBleCellFuctionPowerOnElectricity = 1,
    kBleCellFuctionPowerOnAssistant,
    kBleCellFuctionPowerOnManPower,
    kBleCellFuctionPowerOnStrongAssistant,
    kBleCellFuctionPowerOnMiddleAssistant,
    kBleCellFuctionPowerOnWeakAssistant,
    kBleCellFuctionPowerOff,
    kBleCellFuctionClearMiles,
    kBleCellFuctionLock,
    kBleCellFuctionLightOn,
    kBleCellFuctionLightOff,
    kBleCellFuctionUSBOn,
    kBleCellFuctionUSBOff,
    kBleCellFuctionBatteryUnlock,
    kBleCellFuctionBatteryLock,
    kBleCellFuctionFind,
    kBleCellFuctionStartTravel,
};



@interface QeeBikeTestViewController () <HXQBleManagerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *bikeNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UITableView *bleTableView;

@property (nonatomic, strong) NSDictionary *dataSource;
@property (nonatomic, assign) BOOL hasBeenConnection;

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
    
    [self initialTableView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)initialTableView
{
    self.bleTableView.tableFooterView = [[UIView alloc] init];
    
    [self.bleTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
}

- (void)clearAll
{
    [[HXQBleManager sharedManager] close];
    
    self.bikeNoTextField.text = nil;
    self.keyTextField.text = nil;
    
    [self.sendBtn setTitle:@"连  接" forState:UIControlStateNormal];
    self.statusLabel.text = @"清空数据成功";
}


#pragma mark - HXQBleManagerDelegate

- (void)responseWithType:(BleResponseType)type content:(NSString *)content
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    DLog(@"wyn responseWithType type is %zd content is %@", type, content);
    
    NSString *responseType = @"";
    
    switch (type) {
        case kBleResponseTypeError:
        {
            responseType = @"蓝牙响应超时 ";
        }
            break;
            
        case kBleResponseTypeLock:
        {
            responseType = @"关锁 ";
        }
            break;
            
        case kBleResponseTypeUnlock:
        {
            responseType = @"解锁 ";
        }
            break;
            
        case kBleResponseTypePowerOn:
        {
            responseType = @"通电 ";
        }
            break;
            
        case kBleResponseTypePowerOff:
        {
            responseType = @"断电 ";
        }
            break;
            
        case kBleResponseTypeOpenPowerLock:
        {
            responseType = @"电池锁打开 ";
        }
            break;
            
        case kBleResponseTypeClosePowerLock:
        {
            responseType = @"电池锁关闭 ";
        }
            break;
            
        case kBleResponseTypeClearMileage:
        {
            responseType = @"里程清零 ";
        }
            break;
            
        case kBleResponseTypeLight:
        {
            responseType = @"灯光控制 ";
        }
            break;
            
        case kBleResponseTypeUSB:
        {
            responseType = @"USB控制 ";
        }
            break;
            
        case kBleResponseTypeFind:
        {
            responseType = @"寻车 ";
        }
            break;
            
        case kBleResponseTypeLand:
        {
            responseType = @"解锁、通电、里程清零 ";
        }
            break;
            
        default:
            break;
    }
    
    NSString *statusStr = @"";
    if (0 == [content integerValue]) {
        statusStr = @"成功";
    } else {
        statusStr = @"失败";
    }
    
    
    self.statusLabel.text = [NSString stringWithFormat:@"%@ %@", responseType, statusStr];
}

- (void)connectSuccess:(BOOL)success
{
    if (success) {
        self.hasBeenConnection = YES;
        [self.sendBtn setTitle:@"已连接" forState:UIControlStateNormal];
        
        self.statusLabel.text = @"连接成功";
    } else {
        self.hasBeenConnection = NO;
        [self.sendBtn setTitle:@"连接失败" forState:UIControlStateNormal];
        
        self.statusLabel.text = @"连接失败";
        
        [self connect:nil];
    }
}


- (IBAction)connect:(id)sender
{
    [self.view endEditing:YES];
    
    if (0 >= [self.bikeNoTextField.text length]) {
        [MBProgressHUD showInViewWithoutIndicator:self.view status:@"请输入单车编号" afterDelay:2.0f];
        
        return;
    }
    
    [[HXQBleManager sharedManager] connectBleWithBikeNo:self.bikeNoTextField.text delegate:self];
    
    [self.statusLabel setText:@"连接中"];
    [self.sendBtn setTitle:@"连接中" forState:UIControlStateNormal];
}

- (void)send:(NSString *)key type:(BleRequestType)type content:(NSString *)content
{
    [self.view endEditing:YES];
    
    [[HXQBleManager sharedManager] operationBleWithKey:key
                                                type:type
                                               content:content];
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    
    cell.textLabel.text = [self.dataSource objectForKey:[NSString stringWithFormat:@"%zd", indexPath.row]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.hasBeenConnection)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [MBProgressHUD showInViewWithoutIndicator:self.view
                                           status:@"请先连接蓝牙"
                                       afterDelay:1.0f];
        
        return;
    }
    
    if (0 >= [self.keyTextField.text length]) {
        [MBProgressHUD showInViewWithoutIndicator:self.view
                                           status:@"请输入key"
                                       afterDelay:2.0f];
        
        return;
    }
    
    BleRequestType requestType = kBleRequestTypeUnlock;
    NSString *content = @"0";
    
    switch (indexPath.row) {
        case kBleCellFuctionUnlock:
        {
            requestType = kBleRequestTypeUnlock;
            content = @"0";
        }
            break;
            
        case kBleCellFuctionPowerOnElectricity:
        {
            requestType = kBleRequestTypePowerOn;
            content = @"1";
        }
            break;
            
        case kBleCellFuctionPowerOnAssistant:
        {
            requestType = kBleRequestTypePowerOn;
            content = @"2";
        }
            break;
            
        case kBleCellFuctionPowerOnManPower:
        {
            requestType = kBleRequestTypePowerOn;
            content = @"3";
        }
            break;
            
        case kBleCellFuctionPowerOnStrongAssistant:
        {
            requestType = kBleRequestTypePowerOn;
            content = @"4";
        }
            break;
            
        case kBleCellFuctionPowerOnMiddleAssistant:
        {
            requestType = kBleRequestTypePowerOn;
            content = @"5";
        }
            break;
            
        case kBleCellFuctionPowerOnWeakAssistant:
        {
            requestType = kBleRequestTypePowerOn;
            content = @"6";
        }
            break;
            
        case kBleCellFuctionPowerOff:
        {
            requestType = kBleRequestTypePowerOff;
            content = @"0";
        }
            break;
            
        case kBleCellFuctionClearMiles:
        {
            requestType = kBleRequestTypeClearMileage;
            content = @"0";
        }
            break;
    
        case kBleCellFuctionLock:
        {
            requestType = kBleRequestTypeLock;
            content = @"0";
        }
            break;
            
        case kBleCellFuctionLightOn:
        {
            requestType = kBleRequestTypeLight;
            content = @"1";
        }
            break;
            
        case kBleCellFuctionLightOff:
        {
            requestType = kBleRequestTypeLight;
            content = @"0";
        }
            break;
            
        case kBleCellFuctionUSBOn:
        {
            requestType = kBleRequestTypeUSB;
            content = @"1";
        }
            break;
            
        case kBleCellFuctionUSBOff:
        {
            requestType = kBleRequestTypeUSB;
            content = @"0";
        }
            break;
            
        case kBleCellFuctionBatteryUnlock:
        {
            requestType = kBleRequestTypeOpenPowerLock;
            content = @"0";
        }
            break;
            
        case kBleCellFuctionBatteryLock:
        {
            requestType = kBleRequestTypeClosePowerLock;
            content = @"0";
        }
            break;
            
        case kBleCellFuctionFind:
        {
            requestType = kBleRequestTypeFind;
            content = @"0";
        }
            
        case kBleCellFuctionStartTravel:
        {
            requestType = kBleRequestTypeLaunch;
            content = @"0";
        }
            
        default:
            break;
    }
    
    NSString *keyAES = @"vPXo76sGwXg9uqIR";
    NSString *keyEncode = aesEncryptString(self.keyTextField.text, keyAES);
    
    [self send:keyEncode type:requestType content:content];
    
    [MBProgressHUD showInView:self.view status:@"等待单车返回"];
}


#pragma mark - Getter Methods

- (NSDictionary *)dataSource
{
//    kBleCellFuctionUnlock = 0,
//    kBleCellFuctionPowerOnElectricity = 1,
//    kBleCellFuctionPowerOnAssistant,
//    kBleCellFuctionPowerOnManPower,
//    kBleCellFuctionPowerOnStrongAssistant,
//    kBleCellFuctionPowerOnMiddleAssistant,
//    kBleCellFuctionPowerOnWeakAssistant,
//    kBleCellFuctionPowerOff,
//    kBleCellFuctionClearMiles,
//    kBleCellFuctionLock,
//    kBleCellFuctionLightOn,
//    kBleCellFuctionLightOff,
//    kBleCellFuctionUSBOn,
//    kBleCellFuctionUSBOff,
//    kBleCellFuctionBatteryUnlock,
//    kBleCellFuctionBatteryLock,

    if (nil == _dataSource) {
        _dataSource = @{[NSString stringWithFormat:@"%zd", kBleCellFuctionUnlock]:@"解锁",
                       [NSString stringWithFormat:@"%zd", kBleCellFuctionPowerOnElectricity]:@"通电，电动",
                       [NSString stringWithFormat:@"%zd", kBleCellFuctionPowerOnAssistant]:@"通电，助力",
                       [NSString stringWithFormat:@"%zd", kBleCellFuctionPowerOnManPower]:@"通电，人力",
                       [NSString stringWithFormat:@"%zd", kBleCellFuctionPowerOnStrongAssistant]:@"通电，强助力",
                       [NSString stringWithFormat:@"%zd", kBleCellFuctionPowerOnMiddleAssistant]:@"通电，中助力",
                       [NSString stringWithFormat:@"%zd", kBleCellFuctionPowerOnWeakAssistant]:@"通电，弱助力",
                       [NSString stringWithFormat:@"%zd", kBleCellFuctionPowerOff]:@"断电",
                       [NSString stringWithFormat:@"%zd", kBleCellFuctionClearMiles]:@"里程清零",
                       [NSString stringWithFormat:@"%zd", kBleCellFuctionLock]:@"关锁",
                       [NSString stringWithFormat:@"%zd", kBleCellFuctionLightOn]:@"灯光控制，开灯",
                       [NSString stringWithFormat:@"%zd", kBleCellFuctionLightOff]:@"灯光控制，关灯",
                       [NSString stringWithFormat:@"%zd", kBleCellFuctionUSBOn]:@"USB控制，打开USB充电",
                       [NSString stringWithFormat:@"%zd", kBleCellFuctionUSBOff]:@"USB控制，关闭USB充电",
                       [NSString stringWithFormat:@"%zd", kBleCellFuctionBatteryUnlock]:@"电池锁打开",
                       [NSString stringWithFormat:@"%zd", kBleCellFuctionBatteryLock]:@"电池锁关闭",
                        [NSString stringWithFormat:@"%zd", kBleCellFuctionFind]:@"寻车",
                        [NSString stringWithFormat:@"%zd", kBleCellFuctionStartTravel]:@"解锁、通电、里程清零",};
    }
    
    return _dataSource;
}


@end
