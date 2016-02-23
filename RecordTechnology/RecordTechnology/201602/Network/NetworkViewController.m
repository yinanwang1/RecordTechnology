//
//  NetworkViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/2/23.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "NetworkViewController.h"

@interface NetworkViewController ()

@end

@implementation NetworkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateNetwork:)
                                                 name:AFNetworkingReachabilityDidChangeNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)updateNetwork:(NSNotification *)info
{
    NSDictionary *userInfo = [info userInfo];
    
    NSNumber *statusItem = [userInfo objectForKey:AFNetworkingReachabilityNotificationStatusItem];
    
    switch ([statusItem intValue]) {
        case AFNetworkReachabilityStatusUnknown:
        {
            NSLog(@"AFNetworkReachabilityStatusUnknown");
        }
            break;
            
        case AFNetworkReachabilityStatusNotReachable:
        {
            NSLog(@"AFNetworkReachabilityStatusNotReachable");
        }
            break;
            
        case AFNetworkReachabilityStatusReachableViaWWAN:
        {
            NSLog(@"AFNetworkReachabilityStatusReachableViaWWAN");
        }
            break;
            
        case AFNetworkReachabilityStatusReachableViaWiFi:
        {
            NSLog(@"AFNetworkReachabilityStatusReachableViaWiFi");
        }
            break;
            
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
