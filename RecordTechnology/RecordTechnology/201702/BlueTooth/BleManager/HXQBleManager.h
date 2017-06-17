//
//  HXQBleManager.h
//  qiji
//
//  Created by ArthurWang on 2017/6/15.
//  Copyright © 2017年 huanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HXQBleType.h"

@protocol HXQBleManagerDelegate <NSObject>

@required
- (void)responseWithType:(BleResponseType)type content:(NSString *)content;

- (void)connectSuccess:(BOOL)success;

@end


@interface HXQBleManager : NSObject

+ (instancetype)sharedManager;

/**
 * 根据单车编号连接蓝牙并设置回调代码
 * bikeNoStr  单车编号，用来查找蓝牙名称
 * delegate   回调代理
 **/
- (void)connectBleWithBikeNo:(NSString *)bikeNoStr delegate:(id<HXQBleManagerDelegate>)delegate;

/**
 * 向蓝牙发送type指令，等待响应
 * key        私钥
 * type       指令  eg 4 解锁
 * content    内容， eg 0-成功， 1-失败  或 1-电动 2-混动 3-人力
 **/
- (void)operationBleWithKey:(NSString *)key
                        type:(BleRequestType)type
                     content:(NSString *)content;
/**
 * 关闭蓝牙
 **/

- (void)close;

@end
