//
//  BlueToothViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/2/5.
//  Copyright © 2017年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "BlueToothViewController.h"

#import <CoreBluetooth/CoreBluetooth.h>

static NSString * const kTableViewCell = @"tableViewCell";

#define kServicesUUID @"C4FB2349-72FE-4CA2-94D6-1F3CB16331EE"  // 服务的UUID
#define kCharacteristicUUID @"6A3E4B28-522D-4B3B-82A9-D5E2004534FC" // 特征的UUID

@interface BlueToothViewController () <CBCentralManagerDelegate, CBPeripheralDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

/* 中心管理者 */
@property (nonatomic, strong) CBCentralManager *cMgr;

/* 连接到的外设 */
@property (nonatomic, strong) CBPeripheral *peripheral;

/* 附近蓝牙 */
@property (nonatomic, strong) NSMutableArray *bleViewPerArr;


@end

@implementation BlueToothViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initialNavigationBar];
    
    [self initialTableView];
    
    _cMgr = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Initial Methods

- (void)initialNavigationBar
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"扫描"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(scan:)];
                              
    self.navigationItem.rightBarButtonItem = item;
}

- (void)initialTableView
{
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCell];
}

#pragma mark - CBCentralManagerDelegate, CBPeripheralDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBManagerStateUnknown:
        {
            NSLog(@"CBManagerStateUnknown");
        }
            break;
            
        case CBManagerStateResetting:
        {
            NSLog(@"CBManagerStateResetting");
        }
            break;
            
        case CBManagerStateUnsupported:
        {
            NSLog(@"CBManagerStateUnsupported");
        }
            break;
        
        case CBManagerStateUnauthorized:
        {
            NSLog(@"CBManagerStateUnauthorized");
        }
            break;
            
        case CBManagerStatePoweredOff:
        {
            NSLog(@"CBManagerStatePoweredOff");
        }
            break;
            
        case CBManagerStatePoweredOn:
        {
            NSLog(@"CBManagerStatePoweredOn");
            
            // 在中心管理者成功开启后再进行一些操作
            [self.cMgr scanForPeripheralsWithServices:nil           // 通过某些服务筛选外设
                                              options:nil];         // dict， 条件
        }
            break;
            
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central                          // 中心管理者
 didDiscoverPeripheral:(CBPeripheral *)peripheral                           // 外设
     advertisementData:(NSDictionary<NSString *,id> *)advertisementData     // 外设携带的数据
                  RSSI:(NSNumber *)RSSI                                     // 外设发出的蓝牙信号强度
{
    if (nil == peripheral
        || nil == peripheral.identifier
        || nil == peripheral.name) {
        return;
    }
    
    NSLog(@"%s, central=%@, peripheral=%@, advertisementData=%@, RSSI=%@",
          __FUNCTION__,
          central,
          peripheral,
          advertisementData,
          RSSI);
    
    if (![self.bleViewPerArr containsObject:peripheral]) {
        [self.bleViewPerArr addObject:peripheral];
    }
    
    [self.myTableView reloadData];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"%s", __FUNCTION__);
    
    self.peripheral.delegate = self;
    
    // 大概获取服务和特征
    [self.peripheral discoverServices:nil];
    
    [self.cMgr stopScan];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%s, %@=连接失败", __FUNCTION__, peripheral.name);
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%s, %@=断开连接", __FUNCTION__, peripheral.name);
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"%s", __FUNCTION__);
    
    if (error) {
        NSLog(@"Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        
        return;
    }
    
    CBUUID *serviceUUID = [CBUUID UUIDWithString:kServicesUUID];
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:kCharacteristicUUID];
    
    if ([service.UUID isEqual:serviceUUID]) {
        for (CBCharacteristic *characteristic in service.characteristics) {
            NSLog(@"char = %@", characteristic);
            if ([characteristic.UUID isEqual:characteristicUUID]) {
                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            }
        }
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
    NSLog(@"%s, descriptor is %@", __FUNCTION__, descriptor.value);
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error) {
        NSLog(@"Error discovering services: %@", [error localizedDescription]);
        
        return;
    }
    
    NSLog(@"所有的servicesUUID%@", peripheral.services);
    
    CBUUID *serviceUUID = [CBUUID UUIDWithString:kServicesUUID];
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:kCharacteristicUUID];
    
    for (CBService *service in peripheral.services) {
        NSLog(@"服务%@", service.UUID);
        
        if ([service.UUID isEqual:serviceUUID])
        {
            [peripheral discoverCharacteristics:@[characteristicUUID] forService:service];
        }
        
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"收到特征更新通知。。。");
    
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:kCharacteristicUUID];
    if ([characteristic.UUID isEqual:characteristicUUID])
    {
        if (characteristic.isNotifying) {
            if (characteristic.properties == CBCharacteristicPropertyNotify) {
                NSLog(@"已订阅");
                
                return;
            } else if (characteristic.properties == CBCharacteristicPropertyRead) {
                [peripheral readValueForCharacteristic:characteristic];
            }
        } else {
            NSLog(@"停止已停止");
            
            [self.cMgr cancelPeripheralConnection:peripheral];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"更新特征值时发生错误，错误信息：%@", error.localizedDescription);
        
        return;
    }
    
    if (characteristic.value) {
        NSString *value = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
        
        NSLog(@"读取到特征值为：%@", value);
    } else {
        NSLog(@"未发现特征值");
    }
}



#pragma mark - UITableViewDelegate, UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCell
                                                            forIndexPath:indexPath];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kTableViewCell];
    }
    
    CBPeripheral *per = (CBPeripheral *)self.bleViewPerArr[indexPath.row];
    NSString *bleName = [NSString stringWithFormat:@"%@", per.name];
    cell.textLabel.text = bleName;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.bleViewPerArr count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CBPeripheral *peripheral = (CBPeripheral *)self.bleViewPerArr[indexPath.row];
    self.peripheral = peripheral;
    self.peripheral.delegate = self;
    [self.cMgr connectPeripheral:self.peripheral options:nil];
}


#pragma mark - Target Methods

- (void)scan:(UIBarButtonItem *)item
{
    [self.bleViewPerArr removeAllObjects];
    
    [self.myTableView reloadData];
    
    [self.cMgr scanForPeripheralsWithServices:nil
                                      options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
}


#pragma mark - Getter Methdos

- (CBCentralManager *)cMgr
{
    if (nil == _cMgr) {
        _cMgr = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    
    return _cMgr;
}

- (NSMutableArray *)bleViewPerArr
{
    if (nil == _bleViewPerArr) {
        _bleViewPerArr = [[NSMutableArray alloc] initWithCapacity:5];
    }
    
    return _bleViewPerArr;
}


@end
