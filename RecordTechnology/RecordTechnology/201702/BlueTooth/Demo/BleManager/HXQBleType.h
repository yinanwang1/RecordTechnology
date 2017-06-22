//
//  HXQBleType.h
//  qiji
//
//  Created by ArthurWang on 2017/6/15.
//  Copyright © 2017年 huanxiao. All rights reserved.
//

#ifndef HXQBleType_h
#define HXQBleType_h

typedef NS_ENUM(NSInteger, BleRequestType) {
    kBleRequestTypeLock             = 3,    // 关锁       0-成功   1-失败
    kBleRequestTypeUnlock           = 4,    // 解锁       0-成功   1-失败
    kBleRequestTypePowerOn          = 5,    // 通电       1-电动 2-混动 3-人力
    kBleRequestTypePowerOff         = 6,    // 断电       0-成功   1-失败
    kBleRequestTypeOpenPowerLock    = 10,   // 电池锁打开    0-成功   1-失败
    kBleRequestTypeClosePowerLock   = 11,   // 电池锁关闭    0-成功   1-失败
    kBleRequestTypeClearMileage     = 13,   // 里程清零     0-成功   1-失败
    kBleRequestTypeLight            = 14,   // 灯光控制     0-关灯   1-开灯
    kBleRequestTypeUSB              = 16,   // USB控制     0-关闭usb充电   1-打开usb充电
};

typedef NS_ENUM(NSInteger, BleResponseType) {
    kBleResponseTypeError             = 0,   // 连接失败，断开连接或超时等异常，content中返回错误信息
    
    kBleResponseTypeLock             = 103, // 关锁           0-成功   1-失败
    kBleResponseTypeUnlock           = 104, // 解锁           0-成功   1-失败
    kBleResponseTypePowerOn          = 105, // 通电           0-成功   1-失败
    kBleResponseTypePowerOff         = 106, // 断电           0-成功   1-失败
    kBleResponseTypeOpenPowerLock    = 110, // 电池锁打开      0-成功   1-失败
    kBleResponseTypeClosePowerLock   = 111, // 电池锁关闭      0-成功   1-失败
    kBleResponseTypeClearMileage     = 113, // 里程清零        0-成功   1-失败
    kBleResponseTypeLight            = 114, // 灯光控制        0-成功   1-失败
    kBleResponseTypeUSB              = 116, // USB控制        0-成功   1-失败
};


#endif /* HXQBleType_h */
