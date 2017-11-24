//
//  HXURLShortenService.m
//  store
//
//  Created by Arthur Wang on 14-10-14.
//  Copyright (c) 2014年 Arthur Wang All rights reserved.
//

#import "HXURLShortenService.h"
#import <objc/message.h>

#define BITLY_LOGIN @"huanxiao"
#define BITLY_KEY @"R_a6c48ca3cf7d5bcc75a0e5a9355e0b5d"

static HXURLShortenService *_shareHXURLShortenService = nil;

@interface HXURLShortenItem : NSObject {
@private
    NSString *url;
    id target;
    SEL selector;
}

@property(nonatomic, strong) NSString *url;
@property(nonatomic, strong) id target;
@property(nonatomic, assign) SEL selector;

@end

@implementation HXURLShortenItem

@synthesize url, target, selector;

@end

@implementation HXURLShortenService

+(HXURLShortenService *)sharedInstance {
    if (_shareHXURLShortenService != nil)
        return _shareHXURLShortenService;
    
    _shareHXURLShortenService = [[HXURLShortenService alloc] init];
    return _shareHXURLShortenService;
}

-(void)shortenURL:(NSString *)url target:(id)target selector:(SEL)selector {
    HXURLShortenItem *item = [[HXURLShortenItem alloc] init];
    item.url = url;
    item.target = target;
    item.selector = selector;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self shortenURL:item];
    });
}

-(NSString *)encodeURL:(NSString *)value{
    if (value == nil)
        return @"";
    
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)value,
                                                                                             NULL,
                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                             kCFStringEncodingUTF8));
    return result;
}

- (void)shortenURL:(HXURLShortenItem *)item{
    
    NSString *reqURL = [NSString stringWithFormat:@"http://api.bit.ly/v3/shorten?login=%@&apikey=%@&longUrl=%@&format=txt",
                        BITLY_LOGIN,
                        BITLY_KEY,
                        [self encodeURL:item.url]];
    NSURLResponse *resp = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:reqURL]] returningResponse:&resp error:&error];
    
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    result = [result stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    if (result == nil || [result isEqualToString:@"ALREADY_A_BITLY_LINK"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //[item.target performSelector:item.selector withObject:item.url];
            ((void(*)(id, SEL, id))objc_msgSend)(item.target, item.selector, item.url);
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            //[item.target performSelector:item.selector withObject:result];
            ((void(*)(id, SEL, id))objc_msgSend)(item.target, item.selector, result);
        });
    }
}

@end
