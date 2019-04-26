//
//  CYLObject.m
//  RecordTechnology
//
//  Created by ArthurWang on 2019/4/18.
//  Copyright © 2019 Monkey King. All rights reserved.
//

#import "CYLObject.h"

@interface CYLObject ()

@property (nonatomic, copy) NSString *title;

@end

@implementation CYLObject {
    NSString *_title;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"wyn %@", NSStringFromClass([self class]));
        NSLog(@"wyn %@", NSStringFromClass([super class]));
    }
    return self;
}

- (NSString *)title
{
    return _title;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
}

@end
