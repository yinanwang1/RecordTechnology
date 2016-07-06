//
//  AFNetworkingNewest.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/25.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "AFNetworkingNewest.h"

static AFNetworkingNewest *staticNetworkingNewestApplication = nil;

@implementation AFNetworkingNewest

+ (id)shareAFNetworkingNewestApplication
{
    if ( nil == staticNetworkingNewestApplication )
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
        });
    }
    
    return staticNetworkingNewestApplication;
}

@end
