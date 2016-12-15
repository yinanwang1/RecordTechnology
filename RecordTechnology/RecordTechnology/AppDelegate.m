//
//  AppDelegate.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/19.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "AppDelegate.h"

//#import "YouFireApplication.h"
//#import "AFNetworkingNewest.h"
//#import "CopyViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AppDelegate ()

@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundUpdateTask;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self initDemoStatus];
    
    [[AMapServices sharedServices] setApiKey:@"f0cf86820bbe1e52cd9c33a852076174"];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *,id> *)options
{
//    CopyViewController *VC = (CopyViewController *)app.keyWindow.rootViewController;
//    
//    [VC displayDoc:url];
    
    return YES;
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply
{
    NSLog(@"userInfo is %@.", userInfo);
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"EMHQ" ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSError *error =  nil;
    NSDictionary *replyDictionary = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    reply(replyDictionary);
    
}

- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier
{
    if ([extensionPointIdentifier isEqualToString:@"com.apple.keyboard-service"]) {
        return NO;
    }
    
    return YES;
}



#pragma mark - init Demo status

- (void)initDemoStatus
{
    // Demo:  you fire
//    [YouFireApplication shareYouFireApplication];
    
    // Demo: test AFNetworking
//    [AFNetworkingNewest shareAFNetworkingNewestApplication];
    
}

- (void)beginBackgroundUpdateTask
{
    self.backgroundUpdateTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundUpdateTask];
    }];
}

- (void)endBackgroundUpdateTask
{
    [[UIApplication sharedApplication] endBackgroundTask:self.backgroundUpdateTask];
    
    self.backgroundUpdateTask = UIBackgroundTaskInvalid;
}





@end
