//
//  Style1ViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/23.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "Style1ViewController.h"

@interface Style1ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation Style1ViewController

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
- (IBAction)showMessage:(id)sender {
    
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
    
    self.imageView.image = image;
    
    [picker dismissViewControllerAnimated:YES
                               completion:^{
                                   NSLog(@"Finished");
                               }];
}


@end
