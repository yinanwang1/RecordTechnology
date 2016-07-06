//
//  ModuleListModel.h
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/20.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


#define NUMBER_PICTURES   26

@interface ModuleListModel : NSObject

@property (nonatomic, strong) NSArray *nameListArr;
@property (nonatomic, strong) NSArray *collectionViewDataSource;

@end
