//
//  HXURLShortenService.h
//  store
//
//  Created by Arthur Wang on 14-10-14.
//  Copyright (c) 2014年 Arthur Wang All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HXURLShortenService : NSObject

+(HXURLShortenService *)sharedInstance;

-(void)shortenURL:(NSString *)url target:(id)target selector:(SEL)selector;

@end
