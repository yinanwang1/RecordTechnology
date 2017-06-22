//
//  QeeBikeTestViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/6/17.
//  Copyright © 2017年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "QeeBikeTestViewController.h"

#import "HXQBleManager.h"

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
};



@interface QeeBikeTestViewController () <HXQBleManagerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *bikeNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
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
}

- (void)responseWithType:(BleResponseType)type content:(NSString *)content
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    DLog(@"wyn responseWithType type is %zd content is %@", type, content);
    
    // TODO 显示结果
    
}

- (void)connectSuccess:(BOOL)success
{
    if (success) {
        self.hasBeenConnection = YES;
        [self.sendBtn setTitle:@"已连接" forState:UIControlStateNormal];
    } else {
        self.hasBeenConnection = NO;
        [self.sendBtn setTitle:@"连接失败" forState:UIControlStateNormal];
        
        [self connect:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)connect:(id)sender
{
    [self.view endEditing:YES];
    
    if (0 >= self.bikeNoTextField.text) {
        [MBProgressHUD showInViewWithoutIndicator:self.view status:@"请输入单车编号" afterDelay:2.0f];
        
        return;
    }
    
    [[HXQBleManager sharedManager] connectBleWithBikeNo:self.bikeNoTextField.text delegate:self];
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
                       [NSString stringWithFormat:@"%zd", kBleCellFuctionBatteryLock]:@"电池锁关闭",};
    }
    
    return _dataSource;
}


@end
