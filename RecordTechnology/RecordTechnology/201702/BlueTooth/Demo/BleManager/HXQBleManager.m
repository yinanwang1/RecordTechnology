//
//  HXQBleManager.m
//  qiji
//
//  Created by ArthurWang on 2017/6/15.
//  Copyright © 2017年 huanxiao. All rights reserved.
//

#import "HXQBleManager.h"

#import "BabyBluetooth.h"
#import "AESCipher.h"


static NSString * const kBleNamePrefix              = @"qeebike_";
static NSString * const kServiceUUID                = @"00001802-0000-1000-8000-00805f9b34fb";
static NSString * const kCharacteristicWriteUUID    = @"00002A06-0000-1000-8000-00805f9b34fb";
static NSString * const kCharacteristicReadUUID     = @"00002ABC-0000-1000-8000-00805f9b34fb";
static NSTimeInterval const kTimeOut                = 10.0f;


@interface HXQBleManager ()

@property (nonatomic, strong) BabyBluetooth *babyBluetooth;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) CBService *service;
@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;
@property (nonatomic, strong) CBCharacteristic *readCharacteristic;

@property (nonatomic, strong) NSString *bikeNoStr;
@property (nonatomic, strong) NSMutableArray *operationDataMArr;

@property (nonatomic, weak)   id<HXQBleManagerDelegate> delegate;
@property (nonatomic, assign) BOOL hasConnected;

@end

@implementation HXQBleManager

#pragma mark - Public Methods

+ (instancetype)sharedManager
{
    static HXQBleManager *shareInstace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (nil == shareInstace) {
            shareInstace = [[HXQBleManager alloc] init];
            shareInstace.babyBluetooth = [BabyBluetooth shareBabyBluetooth];
        }
    });
    
    return shareInstace;
}

/**
 * 根据单车编号连接蓝牙并设置回调代码
 * bikeNoStr  单车编号，用来查找蓝牙名称
 * delegate   回调代理
 **/
- (void)connectBleWithBikeNo:(NSString *)bikeNoStr delegate:(id<HXQBleManagerDelegate>)delegate
{
    self.delegate = delegate;
    
    if ([bikeNoStr isEqualToString:self.bikeNoStr])
    {
        if (self.hasConnected) {
            // 已经连接不再进行连接
            return;
        }
        if (nil !=  self.peripheral) {
            self.babyBluetooth.having(self.peripheral).and.channel(self.bikeNoStr).then.connectToPeripherals().begin();
            
            return;
        }
    }
    
    [self.babyBluetooth cancelAllPeripheralsConnection];
    
    self.bikeNoStr = bikeNoStr;
    self.delegate  = delegate;
    
    self.peripheral         = nil;
    self.service            = nil;
    self.writeCharacteristic     = nil;
    self.readCharacteristic     = nil;
    
    // 开始
    [self initialDelegate];
    
    // 开始扫描蓝牙设备
    self.babyBluetooth.scanForPeripherals().begin();
}

/**
 * 向蓝牙发送type指令，等待响应
 * key        私钥
 * type       指令  eg 4 解锁
 * content    内容， eg 0-成功， 1-失败  或 1-电动 2-混动 3-人力
 **/
- (void)operationBleWithKey:(NSString *)key
                       type:(BleRequestType)type
                    content:(NSString *)content
{
    NSData *operationData = [self generateDataWithKey:key type:type content:content];
    
    if (self.hasConnected
        && (nil != self.peripheral)
        && (nil != self.writeCharacteristic)) {
        [self.peripheral writeValue:operationData forCharacteristic:self.writeCharacteristic type:CBCharacteristicWriteWithoutResponse];
    } else {
        if (nil !=  self.peripheral) {
            self.babyBluetooth.having(self.peripheral).and.channel(self.bikeNoStr).then.connectToPeripherals().begin();
            
            if (nil != self.writeCharacteristic) {
                [self.peripheral writeValue:operationData forCharacteristic:self.writeCharacteristic type:CBCharacteristicWriteWithoutResponse];
            } else {
                [self.operationDataMArr addObject:operationData];
            }
            
        } else {
            [self.operationDataMArr addObject:operationData];
        }
        
    }
    
    // 设置超时
    [self performSelector:@selector(sendMessageToBleTimeOut) withObject:nil afterDelay:kTimeOut];
}

/**
 * 关闭蓝牙
 **/

- (void)close
{
    self.hasConnected = NO;
    self.bikeNoStr = nil;
    self.delegate  = nil;
    
    self.peripheral         = nil;
    self.service            = nil;
    self.writeCharacteristic     = nil;
    self.readCharacteristic     = nil;
    [self.operationDataMArr removeAllObjects];
    
    [self.babyBluetooth cancelAllPeripheralsConnection];
    [self.babyBluetooth cancelScan];
}


#pragma mark - Initial Methods

- (void)initialDelegate
{
    __weak typeof(self) weakSelf = self;
    [self.babyBluetooth setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if (central.state != CBCentralManagerStatePoweredOn) {
            [weakSelf responseDelegateWithType:kBleResponseTypeError content:@"蓝牙不能使用，请开启蓝牙"];
        } else {
            DLog(@"蓝牙可用");
        }
    }];
    
    //设置扫描到设备的委托
    [self.babyBluetooth setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        DLog(@"搜索到了设备:%@",peripheral.name);
        
        NSString *bikeBleName = [NSString stringWithFormat:@"%@%@", kBleNamePrefix, weakSelf.bikeNoStr];
        
        if ([peripheral.name isEqualToString:bikeBleName]) {
            weakSelf.peripheral = peripheral;
            
            // 开始连接蓝牙
            weakSelf.babyBluetooth.having(weakSelf.peripheral).and.channel(weakSelf.bikeNoStr).then.connectToPeripherals().discoverServices().begin();
            
            [weakSelf.babyBluetooth cancelScan];
        }
    }];
    
    //设置发现设备的Services的委托
    [self.babyBluetooth setBlockOnDiscoverServicesAtChannel:self.bikeNoStr block:^(CBPeripheral *peripheral, NSError *error) {
        DLog(@"setBlockOnDiscoverServicesAtChannel name %@", peripheral.name);
        
        CBUUID *uuid = [CBUUID UUIDWithString:kServiceUUID];
        CBUUID *writeCharacteristicsUuid = [CBUUID UUIDWithString:kCharacteristicWriteUUID];
        CBUUID *readCharacteristicsUuid = [CBUUID UUIDWithString:kCharacteristicReadUUID];
        
        for (CBService *s in peripheral.services) {
            if ([s.UUID isEqual:uuid]) {
                weakSelf.service = s;
                
                [peripheral discoverCharacteristics:@[writeCharacteristicsUuid, readCharacteristicsUuid] forService:s];
            }
        }
        
    }];
    
    //设置发现设service的Characteristics的委托
    [self.babyBluetooth setBlockOnDiscoverCharacteristicsAtChannel:self.bikeNoStr block:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        DLog(@"===service name:%@",service.UUID);
        for (CBCharacteristic *c in service.characteristics) {
            DLog(@"charateristic name is :%@",c.UUID);
            CBUUID *writeCharacteristicsUuid = [CBUUID UUIDWithString:kCharacteristicWriteUUID];
            CBUUID *readCharacteristicsUuid = [CBUUID UUIDWithString:kCharacteristicReadUUID];
            
            if ([c.UUID isEqual:writeCharacteristicsUuid])
            {
                weakSelf.writeCharacteristic = c;
                
                // 如果有未发送的指令进行发送
                for (NSData *data in weakSelf.operationDataMArr) {
                    [weakSelf.peripheral writeValue:data forCharacteristic:c type:CBCharacteristicWriteWithoutResponse];
                }
                
                [weakSelf.operationDataMArr removeAllObjects];
            } else if ([c.UUID isEqual:readCharacteristicsUuid]) {
                weakSelf.readCharacteristic = c;
                
                [weakSelf.babyBluetooth notify:weakSelf.peripheral
                                characteristic:c
                                         block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
                                             DLog(@"notify value is %@.", characteristics.value);
                                             
                                             CBUUID *uuid = [CBUUID UUIDWithString:kCharacteristicReadUUID];
                                             
                                             if ([characteristics.UUID isEqual:uuid]) {
                                                 [weakSelf resposeData:characteristics.value];
                                             }
                                         }];
            }
        }
    }];
    
    // characteristic 的值改变
    [self.babyBluetooth setBlockOnDidUpdateNotificationStateForCharacteristicAtChannel:self.bikeNoStr block:^(CBCharacteristic *characteristic, NSError *error) {
        DLog(@"characteristic name:%@ value is:%@",characteristic.UUID, characteristic.value);
        
        CBUUID *uuid = [CBUUID UUIDWithString:kCharacteristicReadUUID];
        
        if ([characteristic.UUID isEqual:uuid]) {
            [weakSelf resposeData:characteristic.value];
        }
    }];
    
    //设置读取characteristics的委托
    [self.babyBluetooth setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
        DLog(@"characteristic name:%@ value is:%@",characteristics.UUID,characteristics.value);
        
        CBUUID *uuid = [CBUUID UUIDWithString:kCharacteristicReadUUID];
        
        if ([characteristics.UUID isEqual:uuid]) {
            [weakSelf resposeData:characteristics.value];
        }
    }];
    
    
    //设置查找设备的过滤器
    [self.babyBluetooth setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        
        //最常用的场景是查找某一个前缀开头的设备
        if ([peripheralName hasPrefix:kBleNamePrefix] ) {
            return YES;
        }
        
        return NO;
    }];
    
    
    [self.babyBluetooth setBlockOnCancelAllPeripheralsConnectionBlock:^(CBCentralManager *centralManager) {
        DLog(@"setBlockOnCancelAllPeripheralsConnectionBlock");
    }];
    
    [self.babyBluetooth setBlockOnCancelScanBlock:^(CBCentralManager *centralManager) {
        DLog(@"setBlockOnCancelScanBlock");
    }];
    
    //示例:
    //扫描选项->CBCentralManagerScanOptionAllowDuplicatesKey:忽略同一个Peripheral端的多个发现事件被聚合成一个发现事件
    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@YES};
    //连接设备->
    [self.babyBluetooth setBabyOptionsWithScanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:nil scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];
    
    
    //设置设备连接成功的委托,同一个baby对象，使用不同的channel切换委托回调
    [self.babyBluetooth setBlockOnConnectedAtChannel:self.bikeNoStr block:^(CBCentralManager *central, CBPeripheral *peripheral) {
        DLog(@"%@", [NSString stringWithFormat:@"设备：%@--连接成功",peripheral.name]);
        
        weakSelf.hasConnected = YES;
    }];
    
    //设置设备连接失败的委托
    [self.babyBluetooth setBlockOnFailToConnectAtChannel:self.bikeNoStr block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        DLog(@"设备：%@--连接失败",peripheral.name);
        DLog(@"%@", [NSString stringWithFormat:@"设备：%@--连接失败",peripheral.name]);
        
        weakSelf.hasConnected = NO;
        [weakSelf responseDelegateWithType:kBleResponseTypeError content:@"连接失败"];
    }];
    
    //设置设备断开连接的委托
    [self.babyBluetooth setBlockOnDisconnectAtChannel:self.bikeNoStr block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        DLog(@"设备：%@--断开连接",peripheral.name);
        DLog(@"%@", [NSString stringWithFormat:@"设备：%@--断开失败",peripheral.name]);
        
        weakSelf.hasConnected = NO;
        [weakSelf responseDelegateWithType:kBleResponseTypeError content:@"断开失败"];
    }];
    
    //设置写数据成功的block
    [self.babyBluetooth setBlockOnDidWriteValueForCharacteristicAtChannel:self.bikeNoStr block:^(CBCharacteristic *characteristic, NSError *error) {
        DLog(@"setBlockOnDidWriteValueForCharacteristicAtChannel characteristic:%@ and new value:%@",characteristic.UUID, characteristic.value);
    }];
    
    //设置通知状态改变的block
    [self.babyBluetooth setBlockOnDidUpdateNotificationStateForCharacteristicAtChannel:self.bikeNoStr block:^(CBCharacteristic *characteristic, NSError *error) {
        DLog(@"uid:%@,isNotifying:%@",characteristic.UUID,characteristic.isNotifying?@"on":@"off");
    }];
}


#pragma mark - Deal With Data

- (NSData *)generateDataWithKey:(NSString *)key type:(BleRequestType)type content:(NSString *)content
{
    NSString *keyAES = @"vPXo76sGwXg9uqIR";
    
    NSString *decryptedStr = aesDecryptString(key, keyAES);
    
    DLog(@"decryptedStr is %@", decryptedStr);
    
    NSString *typeStr = [NSString stringWithFormat:@"%zd", type];
    NSString *dataStr = [NSString stringWithFormat:@"%@,%@,%@", decryptedStr, typeStr, content];
    
    NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    
    return data;
}

- (void)resposeData:(NSData *)data
{
    if (0 >= [data length]) {
        [self responseDelegateWithType:kBleResponseTypeError content:@"数据为空"];
        
        return;
    }
    
    NSString *resposeStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSArray<NSString *> *componentsArr = [resposeStr componentsSeparatedByString:@","];
    
    if (2 != [componentsArr count]) {
        [self responseDelegateWithType:kBleResponseTypeError content:@"数据格式不正确"];
        
        return;
    }
    
    NSString *typeStr = [componentsArr objectAtIndex:0];
    NSString *contentStr = [componentsArr objectAtIndex:1];
    
    [self responseDelegateWithType:[typeStr integerValue] content:contentStr];
    
    return;
}

- (void)responseDelegateWithType:(BleResponseType)type content:(NSString *)content
{
    // 取消
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(sendMessageToBleTimeOut) object:nil];
    
    if ((nil != self.delegate)
        && [self.delegate respondsToSelector:@selector(responseWithType:content:)]) {
        [self.delegate responseWithType:type content:content];
    }
}

- (void)sendMessageToBleTimeOut
{
    [self responseDelegateWithType:kBleResponseTypeError content:@"请求超时"];
}


#pragma mark - Getter Methods

- (NSMutableArray *)operationDataMArr
{
    if (nil == _operationDataMArr) {
        _operationDataMArr = [[NSMutableArray alloc] initWithCapacity:5];
    }
    
    return _operationDataMArr;
}



@end
