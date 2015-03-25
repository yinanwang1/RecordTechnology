//
//  Style2ViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/24.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "Style2ViewController.h"

@interface Style2ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *selectedImageView;

@property (weak, nonatomic) IBOutlet UIImageView *belowImageView;
@property (weak, nonatomic) IBOutlet UIImageView *aboveImageView;


@end

@implementation Style2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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


#pragma mark -- target methods

- (IBAction)updateAboveImageView:(id)sender {
    
    self.selectedImageView = self.aboveImageView;
    
    [self pickPhotoFromSystemPhotos];
}


- (IBAction)updateBelowImageView:(id)sender {
    
    self.selectedImageView = self.belowImageView;
    
    [self pickPhotoFromSystemPhotos];
}

- (void)pickPhotoFromSystemPhotos
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    
    [self.view.window.rootViewController presentViewController:imagePicker
                                                      animated:YES
                                                    completion:^{
                                                        NSLog(@"Finished");
                                                    }];
}


#pragma mark --  UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%s.", __func__);
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    self.selectedImageView.image = image;
    
    [picker dismissViewControllerAnimated:YES
                               completion:^{
                                   NSLog(@"Finished");
                               }];
}


@end
