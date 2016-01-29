//
//  CameronViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/1/29.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "CameraViewController.h"

#import "CameraDefinedViewController.h"

@interface CameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CameraDefinedViewControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerViewController;
@property (nonatomic, strong) CameraDefinedViewController *definedVC;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter Getter Methods

- (UIImagePickerController *)imagePickerViewController
{
    if (nil == _imagePickerViewController) {
        _imagePickerViewController = [[UIImagePickerController alloc] init];
        _imagePickerViewController.delegate = self;
        _imagePickerViewController.allowsEditing = YES;
        _imagePickerViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePickerViewController.showsCameraControls = NO;
    }
    
    return _imagePickerViewController;
}

- (CameraDefinedViewController *)definedVC
{
    if (nil == _definedVC) {
        _definedVC = [[CameraDefinedViewController alloc] initWithNibName:@"CameraDefinedViewController"
                                                                   bundle:nil];
        _definedVC.delegate = self;
    }
    
    return _definedVC;
}


#pragma mark - Target Methods

- (IBAction)showCameron:(id)sender
{
    self.definedVC.view.frame = self.imagePickerViewController.cameraOverlayView.frame;
    self.definedVC.view.backgroundColor = [UIColor clearColor];
    self.imagePickerViewController.cameraOverlayView = self.definedVC.view;
    
    [self presentViewController:self.imagePickerViewController
                       animated:YES
                     completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    if (nil == image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    [self.imagePickerViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - CameraDefinedViewControllerDelegate

- (void)didSelectTakePictureBtn
{
    [self.imagePickerViewController takePicture];
}

- (void)didSelectCancelBtn
{
    [self.imagePickerViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
