//
//  PeripheralViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/2/5.
//  Copyright © 2017年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "PeripheralViewController.h"

#import <CoreBluetooth/CoreBluetooth.h>

#define kPeripheralName @"qeebike_123456" // 外围设备的名称
#define kServicesUUID @"00001802-0000-1000-8000-00805f9b34fb"  // 服务的UUID
#define kCharacteristicUUID @"00002ABC-0000-1000-8000-00805f9b34fb" // 特征的UUID 读
#define kCharacteristicWRITEUUID @"00002A06-0000-1000-8000-00805f9b34fb" // 特征的UUID 写


@interface PeripheralViewController () <CBPeripheralManagerDelegate>

@property (nonatomic, strong) CBPeripheralManager *peripheralManager; // 外围设备管理器
@property (nonatomic, strong) NSMutableArray *centralM; // 订阅此外围设备特征的中心设备
@property (nonatomic, strong) CBMutableCharacteristic *characteristicM; // 特征
@property (weak, nonatomic) IBOutlet UITextView *log;


@end

@implementation PeripheralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - CBPeripheralManagerDelegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    switch (peripheral.state) {
        case CBManagerStatePoweredOn:
            NSLog(@"BLE已打开");
            [self writeToLog:@"BLE已打开"];
            // 添加服务
            [self setupSrvice];
            
            break;
            
        default:
            NSLog(@"此设备不支持BLE或未打开蓝牙功能，无法作为外围设备");
            [self writeToLog:@"此设备不支持BLE或未打开蓝牙功能，无法作为外围设备"];
            break;
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
{
    if (error) {
        NSLog(@"向外围设备添加服务失败，错误详情： %@", error.localizedDescription);
        [self writeToLog:[NSString stringWithFormat:@"向外围设备添加服务失败，错误详情： %@", error.localizedDescription]];
        
        return;
    }
    
    NSDictionary *dic = @{CBAdvertisementDataLocalNameKey:kPeripheralName};
    [self.peripheralManager startAdvertising:dic]; // 开始广播
    
    NSLog(@"向外围设备添加了服务并开始广播。。。");
    [self writeToLog:@"向外围设备添加了服务并开始广播。。。"];
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
{
    if (error) {
        NSLog(@"启动广播过程中发生错误，错误信息：%@", error.localizedDescription);
        [self writeToLog:[NSString stringWithFormat:@"启动广播过程中发生错误，错误信息：%@", error.localizedDescription]];
        
        return;
    }
    
    NSLog(@"启动广播。。。");
    
    [self writeToLog:@"启动广播。。。"];
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"中心设备：%@ 已订阅特征：%@。", central, characteristic);
    [self writeToLog:[NSString stringWithFormat:@"中心设备：%@ 已订阅特征：%@。", central, characteristic]];
    
    if (![self.centralM containsObject:central]) {
        [self.centralM addObject:central];
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"didUnsubscribeFromCharacteristic");
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request;
{
    NSLog(@"didReceiveReadRequest");
    
    NSLog(@"request is %@.", request);
    
    if (request.offset > request.characteristic.value.length) {
        [self.peripheralManager respondToRequest:request
                                   withResult:CBATTErrorInvalidOffset];
        return;
    }
    
    if ([[request.characteristic.UUID UUIDString] isEqual:kCharacteristicUUID]) {
//        NSLog(@"respondToRequest value is %@", [[NSString alloc] initWithData:request.characteristic.value
//                                                                     encoding:NSUTF8StringEncoding]);
//        
//        request.value = [request.characteristic.value subdataWithRange:NSMakeRange(request.offset,
//                                                      request.characteristic.value.length - request.offset)];
        
        NSString *valueStr = [NSString stringWithFormat:@"%@ -- %@", kPeripheralName, [NSDate date]];
        NSData *value = [valueStr dataUsingEncoding:NSUTF8StringEncoding];
        
        request.value = value;
        
        
        [self.peripheralManager respondToRequest:request withResult:CBATTErrorSuccess];
    }
    
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray<CBATTRequest *> *)requests
{
    NSLog(@"didReceiveWriteRequests");
    
    for (CBATTRequest *request in requests) {
        NSLog(@"request is %@.", request);
        
        if (request.offset > request.characteristic.value.length) {
            [self.peripheralManager respondToRequest:request
                                          withResult:CBATTErrorInvalidOffset];
            break;
        }
        
        if ([[request.characteristic.UUID UUIDString] isEqual:kCharacteristicUUID]) {
//            NSLog(@"respondToRequest value is %@", [[NSString alloc] initWithData:request.characteristic.value
//                                                                         encoding:NSUTF8StringEncoding]);
//            
//            request.value = [request.characteristic.value subdataWithRange:NSMakeRange(request.offset,
//                                                                                       request.characteristic.value.length - request.offset)];
            
            NSString *valueStr = [NSString stringWithFormat:@"654321"];
            NSData *value = [valueStr dataUsingEncoding:NSUTF8StringEncoding];
            
            request.value = value;
            
            [self.peripheralManager respondToRequest:request withResult:CBATTErrorSuccess];
            
            [self.peripheralManager updateValue:value forCharacteristic:self.characteristicM onSubscribedCentrals:nil];
        }
    }

}

- (void)peripheralManager:(CBPeripheralManager *)peripheral willRestoreState:(NSDictionary<NSString *,id> *)dict
{
    NSLog(@"willRestoreState");
}




#pragma mark - Target Methods

- (IBAction)startClick:(id)sender
{
    _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
}

- (IBAction)transferClick:(id)sender
{
    [self updateCharacteristicValue];
}

- (IBAction)sendMessage:(id)sender
{
    
}



#pragma mark - Setup Peripheral

- (void)updateCharacteristicValue
{
    NSString *valueStr = [NSString stringWithFormat:@"%@ -- %@", kPeripheralName, [NSDate date]];
    NSData *value = [valueStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [self.peripheralManager updateValue:value forCharacteristic:self.characteristicM onSubscribedCentrals:nil];
    
    [self writeToLog:[NSString stringWithFormat:@"更新特征值：%@", valueStr]];
}

- (void)writeToLog:(NSString *)log
{
    self.log.text = [NSString stringWithFormat:@"%@\r\n%@", self.log.text, log];
}

// 创建特征，服务并添加服务到外围设备
- (void)setupSrvice
{
//    NSString *valueStr = [NSString stringWithFormat:@"Beautiful Women"];
//    NSData *value = [valueStr dataUsingEncoding:NSUTF8StringEncoding];
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:kCharacteristicUUID];
    CBMutableCharacteristic *characteristicM = [[CBMutableCharacteristic alloc] initWithType:characteristicUUID
                                                                                  properties:CBCharacteristicPropertyNotify | CBCharacteristicPropertyRead
                                                                                       value:nil
                                                                                 permissions:CBAttributePermissionsReadable];
    self.characteristicM = characteristicM;
    
    
    CBUUID *characteristicUUID2 = [CBUUID UUIDWithString:kCharacteristicWRITEUUID];
    CBMutableCharacteristic *characteristicM2 = [[CBMutableCharacteristic alloc] initWithType:characteristicUUID2
                                                                                  properties: CBCharacteristicPropertyWrite
                                                                                       value:nil
                                                                                 permissions:CBAttributePermissionsWriteable];
    
    
    CBUUID *serviceUUID = [CBUUID UUIDWithString:kServicesUUID];
    CBMutableService *serviceM = [[CBMutableService alloc] initWithType:serviceUUID primary:YES];
    
    [serviceM setCharacteristics:@[characteristicM, characteristicM2]];
    
    [self.peripheralManager addService:serviceM];
}


#pragma mark - Getter Methods

- (NSMutableArray *)centralM
{
    if (nil == _centralM) {
        _centralM = [[NSMutableArray alloc] initWithCapacity:5];
    }
    
    return _centralM;
}


@end
