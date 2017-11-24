//
//  HXPlistReader.h
//  store
//
//  Created by Arthur Wang on 14-10-14.
//  Copyright (c) 2014年 Arthur Wang All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HXPlistReader : NSObject {
    
}

+(HXPlistReader *)plistReaderForFile:(NSString *)file;

-(NSArray *)allKeys;

-(NSString *)stringValueForKey:(NSString *)key;
-(NSArray *)arrayValueForKey:(NSString *)key;
-(NSDictionary *)dictValueForKey:(NSString *)key;
-(BOOL)boolValueForKey:(NSString *)key;
-(NSInteger)intValueForKey:(NSString *)key;
-(float)floatValueForKey:(NSString *)key defaultValue:(float)defaultValue;

-(NSString *)stringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
-(NSArray *)arrayValueForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
-(NSDictionary *)dictValueForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue;
-(BOOL)boolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
-(NSInteger)intValueForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;

@end
