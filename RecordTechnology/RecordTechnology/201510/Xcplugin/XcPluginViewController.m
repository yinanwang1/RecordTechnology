//
//  XcPluginViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/10/27.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "XcPluginViewController.h"

#define XCODE_PATH @"/Applications/Xcode.app/Contents/Info.plist"

@interface XcPluginViewController ()

@end

@implementation XcPluginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)onClickChangeBtn:(id)sender
{
    NSString *username = @"arthurwang";
    NSString *pluginPath = [NSString stringWithFormat:@"/Users/%@/Library/Application Support/Developer/Shared/Xcode/Plug-ins", username];
    
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:XCODE_PATH];
    NSString *xcodeUUID = dictionary[@"DVTPlugInCompatibilityUUID"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error;
    NSArray *pathArray = [fm contentsOfDirectoryAtPath:pluginPath error:&error];
    if (error) {
        NSLog(@"路径错误");
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你猜！"
                                                                                 message:@"亲，你的路径错误了。"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好吧"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           NSLog(@"乌拉拉");
                                                       }];
        [alertController addAction:action];
        
        [self presentViewController:alertController
                           animated:YES
                         completion:^{
                             
                         }];
        
        
        
        return;
    }
    for (NSString *name  in pathArray) {
        if ([name hasSuffix:@".xcplugin"]) {
            NSString *pluginPlistPath = [NSString stringWithFormat:@"%@/%@/Contents/Info.plist", pluginPath, name];
            NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:pluginPlistPath];
            NSMutableArray *arr = [NSMutableArray arrayWithArray:dictionary[@"DVTPlugInCompatibilityUUIDs"]];
            
            if (![arr containsObject:xcodeUUID]) {
                [arr addObject:xcodeUUID];
                [dictionary setValue:arr forKey:@"DVTPlugInCompatibilityUUIDs"];
                [dictionary writeToFile:pluginPlistPath atomically:YES];
            }
        }
    }
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"成功了喽"
                                                                             message:@"XCode适配已成功,所有插件都可以正常使用了~"
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好吧"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       NSLog(@"哇哈哈");
                                                   }];
    [alertController addAction:action];
    
    [self presentViewController:alertController
                       animated:YES
                     completion:^{
                         
                     }];
    
}





@end
