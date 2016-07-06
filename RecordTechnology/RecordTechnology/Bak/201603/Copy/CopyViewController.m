//
//  CopyViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/3/24.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "CopyViewController.h"

#import <QuickLook/QuickLook.h>

@interface CopyViewController () <QLPreviewControllerDelegate, QLPreviewControllerDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) NSURL *fileURL;

@end

@implementation CopyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)displayDoc:(NSURL *)fileURL
{
    self.fileURL = fileURL;
    
    QLPreviewController *previewController = [[QLPreviewController alloc] init];
    
    previewController.delegate = self;
    previewController.dataSource = self;
    
    [self presentViewController:previewController
                       animated:YES
                     completion:nil];
}



#pragma mark - QLPreviewControllerDelegate, QLPreviewControllerDataSource

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    return self.fileURL;
}


@end
