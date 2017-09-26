//
//  YYCopy.h
//  RecordTechnology
//
//  Created by ArthurWang on 2017/9/26.
//  Copyright © 2017年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYCopy : NSObject <NSCopying, NSCoding>

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *age;

@end
