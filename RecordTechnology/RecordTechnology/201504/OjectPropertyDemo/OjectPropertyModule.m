//
//  OjectPropertyModule.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/4/22.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "OjectPropertyModule.h"

#import <objc/objc-runtime.h>

@implementation OjectPropertyModule


- (NSString *)description
{
    return [NSString stringWithFormat:@"the values is %@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@, %@", self.value1, self.value2, self.value3, self.value4, self.value5, self.value6, self.value7, self.value8, self.value9, self.value10, self.value11, self.value12, self.value13, self.value14, self.value15, self.value16, self.value17];
}



- (NSArray*)propertyKeys

{
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        [keys addObject:propertyName];
        
    }
    
    free(properties);
    
    return keys;
    
}



- (BOOL)reflectDataFromOtherObject:(NSObject*)dataSource

{
    
    BOOL ret = NO;
    
    for (NSString *key in [self propertyKeys]) {
        
        if ([dataSource isKindOfClass:[NSDictionary class]]) {
            
            ret = ([dataSource valueForKey:key]==nil)?NO:YES;
            
        }
        
        else
            
        {
            
            ret = [dataSource respondsToSelector:NSSelectorFromString(key)];
            
        }
        
        if (ret) {
            
            id propertyValue = [dataSource valueForKey:key];
            
            //该值不为NSNULL，并且也不为nil
            
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                
                [self setValue:propertyValue forKey:key];
                
            }
            
        }
        
    }
    
    return ret;
    
}


@end
